.data
    n: .long 6
    s: .long 0
    printf_format: .asciz "%d\n"

.text
.global main

main:
    movl n, %ecx
    xorl %eax, %eax
    xorl %ebx, %ebx

et_loop:
    cmpl $0, %ecx
    je et_exit
    movl %ecx, %eax
    mull %eax
    addl %eax, %ebx
    decl %ecx
    jmp et_loop

et_exit:
    movl %ebx, s

    pushl s
    pushl $printf_format
    call printf
    addl $8, %esp

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
