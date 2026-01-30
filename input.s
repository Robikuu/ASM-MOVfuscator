.data
    x: .long 4
    y: .long 2
    printf_format: .asciz "%d\n"

.text

.global main

main:
    movl x, %eax
    movl y, %ebx

    orl %eax, y

    pushl %eax
    pushl $printf_format
    call printf
    addl $8, %esp

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
