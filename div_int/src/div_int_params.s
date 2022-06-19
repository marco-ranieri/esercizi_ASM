# divisione intera tra due numeri interi
# passati direttamente come parametri del programma
# stampa parte intera a video


.section .data

    errore_str: .ascii "Errore nell'inserimento dei parametri\n"
    errore_str_len: .long . - errore_str

    num1: .long 0
    num2: .long 0

.section .text
.global _start

_start:

    popl %ecx                           # faccio il pop dallo stack del primo valore -> numero argomenti
    popl %ecx                           # faccio il pop dallo stack del secondo valore -> nome programma
    

# ------CONVERSIONE NUMERI DA STRINGA A INTERO -------

    # primo numero
    str2num_1:

        popl %eax                       # carico l'indirizzo dell'inizio del primo parametro in %esi
        call str2num

        movl %eax, num1
    
    # secondo numero
    str2num_2:

        popl %eax                       # carico l'indirizzo dell'inizio del secondo parametro in %esi
        call str2num

        movl %eax, num2



#    handle_par:
#
#        popl %eax                       # pop in eax del parametro
#        # testl %eax, %eax                # verifico che eax non sia NULL
#        # jz fine_handle                  # se è NULL ho finito e vado alla fine
#
#        popl %ebx
#        # testl %ebx, %ebx                
#        # jz fine_handle                  # se è NULL ho finito e vado alla fine
#
#        popl %ecx
#        testl %ecx, %ecx                
#        jne errore_parametri
#
#        jmp division
#    
#
#    errore_parametri:
#
#        # SYSCALL PRINT
#        movl $4, %eax
#        movl $1, %ebx
#        leal errore_str, %ecx
#        movl errore_str_len, %edx
#        int $0x80
#
#        # SYSCALL EXIT
#        movl $1, %eax
#        movl $0, %ebx
#        int $0x80


division:

    movl num1, %eax
    movl num2, %ebx
    movl $0, %edx
    divl %ebx

print:

    call num2str


# SYSTEM CALL EXIT
movl $1, %eax
xorl %ebx, %ebx   
int $0x80           
