# divisione intera tra due numeri interi
# input dall'utente da terminale
# stampa parte intera a video

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

    movb (%ecx, %esi, 1), %bl       # muovo ciò che sta all'indirizzo (%ecx + %esi*1), in %bl 
                                    # ( => al primo ciclo, la prima lettera della stringa)
                                    # (nei cicli successivi, man mano incremento %ecx di 1 quindi passo alle lettere successive)
    cmp $10, %bl                    # verifico se il carattere "\n" è stato letto (ascii 10 = line feed LF)

    je fine_str_to_num1             # se sì, salta a fine loop

    subb $48, %bl                   # converte cifra da string a numero in ebx

    movl $10, %edx                  # mette il valore 10 in %edx
    mulb %dl                        # dl è 1 byte => moltiplica al per dl e mette il risultato in ax (al primo giro sarà zero)
    addl %ebx, %eax                 # sommo ebx ad eax e lo salvo in eax, a disposizione per il prossimo giro (verrà moltipicato per 10 prima che gli venga sommato il nuovo ebx)

    inc %ecx                        # incremento di 1 ecx per passare alla cifra successiva della stringa
    jmp loop1                       # ricomincio il ciclo


fine_str_to_num1:

    movl %eax, num1                 # salvo il valore numerico trovato nella variabile num1


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


# CALCOLO DIVISIONE

division:

    xorl %eax, %eax                 # resetto a zero tutti i registri primari
    xorl %ebx, %ebx
    xorl %ecx, %ecx
    xorl %edx, %edx

    movl num1, %eax
    movl num2, %ebx
    divl %ebx

    call itoa

# SYSTEM CALL EXIT
movl $1, %eax
xorl %ebx, %ebx   
int $0x80           
