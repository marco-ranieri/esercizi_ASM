# leggo i parametri del comando da terminale e li stampo in output
# NB: usare pop e push per salvare/richiamare i parametri usando lo stack


.section .data

    new_line_char: .byte 10             # carattere di "a capo", definito come byte (8bit)

.section .text
.global _start

_start:

    popl %ecx                           # faccio il pop dallo stack del primo valore -> numero argomenti
    popl %ecx                           # faccio il pop dallo stack del secondo valore -> nome programma

    handle_par:

        popl %ecx                       # pop in ecx del parametro
        testl %ecx, %ecx                # verifico che ecx non sia NULL
        jz fine_handle                  # se è NULL ho finito e vado alla fine
        call print_par                  # altrimenti chiamo la funzione di stampa a video del parametro
        jmp handle_par                  # ricomincio il ciclo
    
    fine_handle:
    
        movl $1, %eax                   # SYSCALL EXIT
        movl $0, %ebx
        int $0x80
        
# FUNZIONE PRINT PARAMETERS

.type print_par, @function

print_par:

    call count_char                     # chiamo la funzione per calcolare la lunghezza della stringa da stampare

    movl $4, %eax                       # SYSCALL WRITE (ecx ed edx sono già calcolati da hande_par e count_char)
    movl $1, %ebx
    int $0x80

    movl $4, %eax                       # SYSCALL WRITE per carattere "a capo" -> "\n"
    movl $1, %ebx
    leal new_line_char, %ecx
    movl $1, %edx
    int $0x80

    ret                                 # return



# FUNZIONE COUNT CHARACTERS

.type count_char, @function

count_char:

    movl $0, %edx                       # resetto edx

    loop_count:
        movb (%ecx, %edx), %al          # metto il carattere della stringa in al
        testb %al, %al                  # verifico se è zero ("\0" = fine stringa)
        jz end_count                    # se è zero salto alla fine della funzione count_char
        inc %edx                        # incremento edx per accedere alla lettera successiva al prossimo loop
        jmp loop_count                  # ricomincio il loop


    end_count:
        ret                             # return
