# confronta 2 numeri caricati in EAX ed EBX
# stampa stringa che indica quale è maggiore e quale minore
# oppure indica che sono uguali

.section .data

maggiore: .ascii "Il numero in EAX è maggiore del numero in EBX\n"
maggiore_len: .long . - maggiore

minore: .ascii "Il numero caricato in EAX è minore del numero caricato in EBX\n"
minore_len: .long . - minore

uguali: .ascii "I numeri in EAX ed EBX sono uguali\n"
uguali_len: .long . - uguali

.section .text
    .global _start

_start:

    movl $1000, %eax
    movl $100, %ebx

    cmpl %ebx, %eax

    jg eax_maggiore
    jl eax_minore

eax_ebx_uguali:

    movl $4, %eax           # syscall print ??
    movl $0, %ebx
    leal uguali, %ecx
    movl uguali_len, %edx
    int $0x80

    jmp exit

eax_maggiore:

    movl $4, %eax           # syscall print ??
    movl $0, %ebx
    leal maggiore, %ecx
    movl maggiore_len, %edx
    int $0x80

    jmp exit

eax_minore:

    movl $4, %eax           # syscall print ??
    movl $0, %ebx
    leal minore, %ecx
    movl minore_len, %edx
    int $0x80

    jmp exit 

exit:

    movl $1, %eax
    movl $0, %ebx
    int $0x80
