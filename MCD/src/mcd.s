# calcola massimo comune divisore di due numeri naturali
# parametro a è in eax - parametro b in ebx
# valore di ritorno in ecx
#
# sorgente C da tradurre:

# unsigned int MCD(unsigned int a, unsigned int b) {
#   if (a==0 && b==0)
#       b=1;
#   else if (b==0)
#       b=a;
#   else if (a!=0)
#       while (a!=b)
#           if (a<b)
#               b = b - a;
#           else
#               a = a - b;
#   return b;
# }

# 12 20
.section .data
    ask_num1: .ascii "Inserisci il primo numero:"
    ask_num1_len: .long . - ask_num1

    ask_num2: .ascii "Inserisci il secondo numero:"
    ask_num2_len: .long . - ask_num2

    num1_str: .ascii "000000"
    num1_str_len: .long . - num1_str

    num2_str: .ascii "000000"
    num2_str_len: .long . - num2_str

    num1: .long 0
    num2: .long 0

    numstr: .ascii "00000000000"     # string output
	numtmp: .ascii "00000000000"     # temporary string

.section .text
.global _start

_start:

# --- LETTURA INPUT ------

# stampa richiesta primo numero
movl $4, %eax
movl $1, %ebx
leal ask_num1, %ecx
movl ask_num1_len, %edx
int $0x80

# lettura input primo numero da tastiera (scanf)
movl $3, %eax
movl $1, %ebx
leal num1_str, %ecx
movl num1_str_len, %edx
incl %edx
int $0x80


# stampa richiesta secondo numero
movl $4, %eax
movl $1, %ebx
leal ask_num2, %ecx
movl ask_num2_len, %edx
int $0x80

# lettura input secondo numero da tastiera (scanf)
movl $3, %eax
movl $1, %ebx
leal num2_str, %ecx
movl num2_str_len, %edx
incl %edx
int $0x80

# ------CONVERSIONE NUMERI DA STRINGA A INTERO -------

# primo numero
str_to_num1:

    leal num1_str, %esi             # carico l'indirizzo della variabile num1_str in %esi

    xorl %eax, %eax                 # resetto a zero tutti i registri primari
    xorl %ebx, %ebx
    xorl %ecx, %ecx
    xorl %edx, %edx

loop1:

    movb (%ecx, %esi, 1), %bl       # muovo ciò che sta all'indirizzo %ecx%esi*1, in %bl 
                                    # ( => al primo ciclo, la prima lettera della stringa)
                                    # (nei cicli successivi, man mano incremento %ecx di 1 quindi passo alle lettere successive)
    cmp $10, %bl                    # verifico se il carattere "\n" è stato letto (ascii 10 = line feed LF)

    je fine_str_to_num1             # se sì, salta a fine loop

    subb $48, %bl                   # converte cifra da string a numero in ebx

    movl $10, %edx                  # mette il valore 10 in %edx
    mulb %dl                        # dl è 1 byte => moltiplica al per dl e mette il risultato in ax (al primo giro sarà zero)
    addl %ebx, %eax                 # sommo ebx ad eax e lo salvo in eax, a disposizione per il prossimo giro (verrà moltipicato per 10 prima ceh gli venga sommato il nuovo ebx)

    inc %ecx                        # incremento di 1 ecx per passare alla cifra successiva della stringa
    jmp loop1                       # ricomincio il ciclo


fine_str_to_num1:

    movl %eax, num1             # salvo il valore numerico trovato nella variabile num1


# secondo numero
str_to_num2:

    leal num2_str, %esi             # carico l'indirizzo della variabile num2_str in %esi

    xorl %eax, %eax                 # resetto a zero tutti i registri primari
    xorl %ebx, %ebx
    xorl %ecx, %ecx
    xorl %edx, %edx

loop2:

    movb (%ecx, %esi, 1), %bl       # muovo ciò che sta all'indirizzo %ecx%esi*1, in %bl 
                                    # ( => al primo ciclo, la prima lettera della stringa)
                                    # (nei cicli successivi, man mano incremento %ecx di 1 quindi passo alle lettere successive)
    cmp $10, %bl                    # verifico se il carattere "\n" è stato letto (ascii 10 = line feed LF)

    je fine_str_to_num2             # se sì, salta a fine loop

    subb $48, %bl                   # converte cifra da string a numero in ebx

    movl $10, %edx                  # mette il valore 10 in %edx
    mulb %dl                        # dl è 1 byte => moltiplica al per dl e mette il risultato in ax (al primo giro sarà zero)
    addl %ebx, %eax                 # sommo ebx ad eax e lo salvo in eax, a disposizione per il prossimo giro (verrà moltipicato per 10 prima ceh gli venga sommato il nuovo ebx)

    inc %ecx                        # incremento di 1 ecx per passare alla cifra successiva della stringa
    jmp loop2                       # ricomincio il ciclo


fine_str_to_num2:

    movl %eax, num2             # salvo il valore numerico trovato nella variabile num2


# ----- CALCOLO IL MCD -------

MCD:

    movl num1, %eax             # copio il primo numero in eax
    movl num2, %ebx             # copio il secondo numero in ebx

    cmpl $0, %eax               # confronto eax con zero
        jne else1               # se è eax != da zero jump a else1
    cmpl $0, %ebx               # altrimenti confronto ebx con zero
        jne else1               # se ebx è != da zero jump a else1
    movl $1, %ebx               # altrimenti metto il valore 1 in ebx
    jmp fine_mcd                # e salto a fine programma

    else1:
        cmpl $0, %ebx           # confronto ebx con zero
            jne else2           # se ebx è != da zero salto a else2
        movl %eax, %ebx         # altrimenti sposto eax in ebx
        jmp fine_mcd            # e salto a fine programma

    else2:
        cmpl $0, %eax           # confronto eax con zero
            je fine_mcd         # se eax è == a zero salto a fine programma

        while:
            cmpl %eax, %ebx     # se inece eax è diverso da zero (e anche ebx), confronto eax ed ebx
                je fine_mcd     # se sono uguali salto a fine programma
            cmpl %ebx, %eax     # altrimenti confronto ancora eax con ebx
                jge else3       # se eax è >= a ebx, jump a else3
            subl %eax, %ebx     # altrimenti, se eax è < di ebx, sottraggo ebx - eax e lo salvo in ebx
        jmp while               # e ricomincio il while

    else3:
        subl %ebx, %eax         # se eax era >= ad ebx, sottraggo eax - ebx e lo salvo in eax
        jmp while               # e ricomincio il while


fine_mcd:


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
