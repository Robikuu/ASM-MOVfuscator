.data
    scanf_format: .asciz "%d"
    printf_format: .asciz "%d\n"

    xor_row_0:
        .byte 0, 1
    xor_row_1:
        .byte 1, 0
    table_xor:
        .long xor_row_0
        .long xor_row_1
    
    and_row_0:
        .byte 0, 0
    and_row_1:
        .byte 0, 1
    table_and:
        .long and_row_0
        .long and_row_1

    or_row_0:
        .byte 0, 1
    or_row_1:
        .byte 1, 1
    table_or:
        .long or_row_0
        .long or_row_1

    table_not:
        .byte 1, 0

.text
.global main
main:
    movl $1, %eax # A = 1
    movl $0, %ebx # B = 0

    # xor(A, not B)
    movb table_not(%ebx), %dl # not B
    movzx %dl, %ebx # B = not B

    movl table_xor(,%eax,4), %ecx # mai intai se acceseaza linia
    movb (%ecx, %ebx, 1), %dl # dupa coloana
    movzx %dl, %ecx # C = A ^ B

    pushl %ecx
    pushl $printf_format
    call printf
    addl $8, %esp

    movl $1, %eax
    movl $0, %ebx
    int $0x80
