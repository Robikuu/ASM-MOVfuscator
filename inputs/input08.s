.data
    n: .long 10
    printf_format: .asciz "%d\n"

.text
.global main

main:
    mov n, %ecx
    mov $1, %eax

et_loop:
    mul %ecx
    loop et_loop

    pushl %eax
    pushl $printf_format
    call printf
    addl $8, %esp

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
