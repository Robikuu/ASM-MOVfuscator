.data
    x: .long 21
    y: .long 4
    printf_format: .asciz "%d\n"

.text

.global main

main:
    movl x, %eax
    movl y, %ebx

    movl $0, %edx
    divl %ebx
    
    pushl %eax
    pushl $printf_format
    call printf 
    addl $8, %esp

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
