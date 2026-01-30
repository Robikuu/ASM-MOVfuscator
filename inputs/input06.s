.data
    printf_format: .asciz "%d\n"

.text
.global main

main:
    mov $0xff67ffff, %ecx
    mov $0x5263dfaa, %eax
    cmp %ecx, %eax
    jge et_exit

et_1:
    mov $4, %ecx

    pushl %ecx
    pushl $printf_format
    call printf
    addl $8, %esp

et_exit:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80