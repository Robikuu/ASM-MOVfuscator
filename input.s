.data
    x: .long 10
    y: .long 3
    printf_format: .asciz "%d\n"

.text

.global main

main:
    movl x, %eax
    movl y, %ebx
    movl $0, %edx
    divl %ebx
    mull %ebx

    pushl %eax
    pushl $printf_format
    call printf
    addl $8, %esp

exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
