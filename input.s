.data
    x: .long -32
    y: .long -16
    printf_format: .asciz "%d\n"

.text

.global main

main:
    movl x, %ecx
    movl y, %edx
    addl %ecx, %edx

    pushl %edx
    pushl $printf_format
    call printf
    pop %eax
    pop %eax

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
