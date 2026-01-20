.data
    x: .space 4
    printf_format: .asciz "%d\n"

.text

.global main

main:
    movl $56789, %ebx
    movl %ebx, x

    pushl x
    pushl $printf_format
    call printf
    addl $8, %esp

    movl %eax, %eax
    movl $12, %eax

exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
