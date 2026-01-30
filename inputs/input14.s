.data
    n: .long 6
    v: .word 10, 20, 40, 60, 100, 5
    printf_format: .asciz "%d\n"

.text
.global main

main:
    lea v, %edi
    mov $1, %ecx
    mov (%edi, %ecx, 4), %edx

etexit:
    pushl %edx
    pushl $printf_format
    call printf
    addl $8, %esp

    mov $1, %eax
    mov $0, %ebx
    int $0x80
