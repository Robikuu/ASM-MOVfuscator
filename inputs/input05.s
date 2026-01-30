.data
    printf_format: .asciz "%d %d\n"
.text
.global main

main:
    mov $0x2, %eax
    mov $0x00000001, %edx
    mov $2, %ebx
    div %ebx

    pushl %edx
    pushl %eax
    pushl $printf_format
    call printf
    addl $8, %esp

et_exit:
    movl $1, %eax
    xor %ebx, %ebx
    int $0x80
