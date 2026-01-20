.data
    x: .long 3
    y: .long 4
    printf_format: .asciz "%d\n"

.text

.global main

main:
    movl x, %eax
    movl y, %ebx
    addl %ebx, %eax

    pushl %eax
    pushl $printf_format
    call printf
    pop %eax
    pop %eax

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
