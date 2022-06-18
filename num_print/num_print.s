# somma numeri 100, 33 e 68
# salva in variabile "somma"
# stampa il risultato

.section .data
    
somma:
    .ascii "000\n"


.section .text
    .global _start

_start:

    movl $100, %eax
    addl $33, %eax
    addl $68, %eax          # somma: 201

    leal somma, %esi

    movl $10, %ebx
    div %bl                 # bl è un byte (primi 8 bit di ebx) --> divide ax per bl, il quoziente viene memorizzato in al mentre il resto in ah
                            # al: 20 ah: 1
    addb $48, %ah           # converto in carattere -> "b" perché sto lavorando con registri ad 1 byte ("w" per 16bit, "l" per 32bit)
    movb %ah, 2(%esi)       # sposto il carattere "1" contenuto in ah, al terzo posto della stringa "somma" utilizzando indirizzamento 
                            # indiretto (l'indirizzo di memoria della stringa somma è contenuto nel registro %esi) 
                            # con spiazzamento (2-> accedo al terzo carattere)
    xorb %ah, %ah           # AZZERO il registro ah per prepararlo al prossimo carattere

    # --- RIPETO ---

    div %bl
    addb $48, %ah
    movb %ah, 1(%esi)
    xorb %ah, %ah


    div %bl
    addb $48, %ah
    movb %ah, (%esi)
    xorb %ah, %ah

    # --- SYSCALL WRITE ---

    movl $4, %eax
    movl $1, %ebx
    leal somma, %ecx
    movl $4, %edx
    int $0x80

    # SYSCALL EXIT ---

    movl $1, %eax
    movl $0, %ebx
    int $0x80


