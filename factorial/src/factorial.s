# legge da tastiera un numero naturale
# calcola il fattoriale
# stampa a video il risultato


.section .data

ask_num: .ascii "Inserire un numero \n"
ask_num_len: .long . - ask_num

num_str: .ascii "0000"
num_str_len: .long . - num_str


numstr: .ascii "00000000000"     # string output
numtmp: .ascii "00000000000"     # temporary string


.section .text
.global _start

_start:

# ----- RICHIESTA TERMINALE + LETTURA INPUT ------

# SYSCALL PRINT - ask_num
movl $4, %eax
movl $1, %ebx
leal ask_num, %ecx
movl ask_num_len, %edx
int $0x80

# SYSCALL READ - num_str
movl $3, %eax
movl $1, %ebx
leal num_str, %ecx
movl num_str_len, %edx
incl %edx
int $0x80


# ----- CONVERSIONE DA STRINGA A INTERO ------

str_to_num:

    leal num_str, %esi              # carico l'indirizzo della variabile num_str in %esi

    xorl %eax, %eax                 # resetto a zero tutti i registri primari
    xorl %ebx, %ebx
    xorl %ecx, %ecx
    xorl %edx, %edx

loop1:

    movb (%ecx, %esi, 1), %bl       # muovo ciò che sta all'indirizzo (%ecx + %esi*1), in %bl 
                                    # ( => al primo ciclo, la prima lettera della stringa)
                                    # (nei cicli successivi, man mano incremento %ecx di 1 quindi passo alle lettere successive)
    cmp $10, %bl                    # verifico se il carattere "\n" è stato letto (ascii 10 = line feed LF)

    je fine_str_to_num              # se sì, salta a fine loop

    subb $48, %bl                   # converte cifra da string a numero in ebx

    movl $10, %edx                  # mette il valore 10 in %edx
    mulb %dl                        # dl è 1 byte => moltiplica al per dl e mette il risultato in ax (al primo giro sarà zero)
    addl %ebx, %eax                 # sommo ebx ad eax e lo salvo in eax, a disposizione per il prossimo giro (verrà moltipicato per 10 prima che gli venga sommato il nuovo ebx)

    inc %ecx                        # incremento di 1 ecx per passare alla cifra successiva della stringa
    jmp loop1                       # ricomincio il ciclo


fine_str_to_num:

    # movl %eax, num                  # salvo il valore numerico trovato nella variabile num

# ------ CALCOLO IL FATTORIALE ------
# ---NB: il numero si trova in eax---

factorial:

movl %eax, %ecx

loop2:

    dec %ecx                            # decremento ecx
    cmpl $0, %ecx                       # se ecx è zero, esci da loop prima di moltiplicare di nuovo
    je fine_factorial                   
    mull %ecx                           # %ecx * %eax --> %eax (in più, volendo in %edx ci sono gli altri 32 bit più significativi del risultato)
    jmp loop2                           # continua il loop

fine_factorial:

    movl $10, %ebx             # carica 10 in EBX (usato per le divisioni)
	movl $0, %ecx              # azzera il contatore ECX

	leal numtmp, %esi          # carica l'indirizzo di 'numtmp' in ESI


    continua_a_dividere:

        movl $0, %edx              # azzera il contenuto di EDX
        divl %ebx                  # divide per 10 il numero ottenuto

        addb $48, %dl              # aggiunge 48 al resto della divisione
        movb %dl, (%ecx,%esi,1)    # sposta il contenuto di DL in numtmp

        inc %ecx                   # incrementa il contatore ECX

        cmp $0, %eax               # controlla se il contenuto di EAX è 0

        jne continua_a_dividere


        movl $0, %ebx              # azzera un secondo contatore in EBX

        leal numstr, %edx          # carica l'indirizzo di 'numstr' in EDX

    ribalta:

        movb -1(%ecx,%esi,1), %al  # carica in AL il contenuto dell'ultimo byte di 'numtmp'
        movb %al, (%ebx,%edx,1)    # carica nel primo byte di 'numstr' il contenuto di AL

        inc %ebx                   # incrementa il contatore EBX

        loop ribalta


    stampa:

        movb $10, (%ebx,%edx,1)    # aggiunge il carattere '\n' in fondo a 'numstr'

        inc %ebx
        movl %ebx, %edx            # carica in EDX la lunghezza della stringa 'numstr'
        movl $4, %eax              # carica in EAX il codice della syscall WRITE
        movl $1, %ebx              # carica in EBX il codice dello standard output
        leal numstr, %ecx          # carica in ECX l'indirizzo della stringa 'numstr'
        int $0x80                  # esegue la syscall

fine:
    ; movl %eax, %ecx             # a fine programma, salvo eax (il MCD trovato) in ecx
    movl $1, %eax               # -
    xorl %ebx, %ebx             # -
    int $0x80                   # system call EXIT
