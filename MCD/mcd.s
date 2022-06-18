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
    ask_num1: .ascii "Inserisci il primo numero\n"
    ask_num1_len: .long . - ask_num_1

    ask_num2: .ascii "Inserisci il secondo numero\n"
    ask_num2_len: .long . - ask_num_2

    num1_str: .ascii "000000"
    num1_str_len: .long . - num1_str

    num2_str: .ascii "000000"
    num2_str_len: .long . - num2_str

    num1: .long 0
    num2: .long 0

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



