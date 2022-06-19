# ------CONVERSIONE NUMERI DA STRINGA A INTERO -------


.section .data
    # num_temp: .long 0


.section .text
	.global str2num

.type str2num, @function

# CONVERTO STRINGA A NUMERO
str2num:

    movl %eax, %esi              # carico l'indirizzo della variabile input_1 in %esi

    xorl %eax, %eax                 # resetto a zero tutti i registri primari
    xorl %ebx, %ebx
    xorl %ecx, %ecx
    xorl %edx, %edx

loop1:

    movb (%ecx, %esi, 1), %bl       # muovo ciò che sta all'indirizzo (%ecx + %esi*1), in %bl 
                                    # ( => al primo ciclo, la prima lettera della stringa)
                                    # (nei cicli successivi, man mano incremento %ecx di 1 quindi passo alle lettere successive)
    cmp $0, %bl                    # verifico se il carattere "\n" è stato letto (ascii 10 = line feed LF)

    je fine_str2num                    # se sì, salta a fine loop

    subb $48, %bl                   # converte cifra da string a numero in ebx

    movl $10, %edx                  # mette il valore 10 in %edx
    mulb %dl                        # dl è 1 byte => moltiplica al per dl e mette il risultato in ax (al primo giro sarà zero)
    addl %ebx, %eax                 # sommo ebx ad eax e lo salvo in eax, a disposizione per il prossimo giro (verrà moltipicato per 10 prima che gli venga sommato il nuovo ebx)

    inc %ecx                        # incremento di 1 ecx per passare alla cifra successiva della stringa
    jmp loop1                       # ricomincio il ciclo


fine_str2num:

    # movl %eax, num_temp             # salvo il valore numerico trovato nella variabile num_temp
    ret
