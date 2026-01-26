.data
    x: .long 100
    y: .long 16
    printf_format: .asciz "%d\n"

.text

.global main

main:
    movl x, %ecx
    movl y, %edx
    addl %ecx, %edx

    movl $1, %eax
    xor %ebx, %ebx
    int $0x80
