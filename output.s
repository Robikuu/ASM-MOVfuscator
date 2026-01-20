.data
    x: .long 3
    y: .long 4
    printf_format: .asciz "%d\n"

	copy_eax: .space 4
	copy_ebx: .space 4
	copy_ecx: .space 4
	copy_edx: .space 4
	copy_esi: .space 4
	copy_edi: .space 4
	copy_esp: .space 4
	copy_ebp: .space 4
	_eax: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	_ebx: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	_ecx: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	_edx: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	_esi: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	_edi: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	_src_tmp: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	xor_row_0: .byte 0, 1
	xor_row_1: .byte 1, 0
	and_row_0: .byte 0, 0
	and_row_1: .byte 0, 1
	or_row_0: .byte 0, 1
	or_row_1: .byte 1, 1
	table_not: .byte 1, 0
	.align 4
	table_xor: .long xor_row_0, xor_row_1
	.align 4
	table_and: .long and_row_0, and_row_1
	.align 4
	table_or: .long or_row_0, or_row_1

.text

.global main

main:
    movl x, %eax
    movl y, %ebx
	movl %eax, copy_eax
	movl %ebx, copy_ebx
	movl %ecx, copy_ecx
	movl %edx, copy_edx
	movl %esi, copy_esi
	movl %edi, copy_edi
	movl %ebp, copy_ebp
	movl copy_ebx, %edx
	movl %edx, %eax
	shrl $0, %eax
	andl $1, %eax
	movb %al, _src_tmp + 0
	movl %edx, %eax
	shrl $1, %eax
	andl $1, %eax
	movb %al, _src_tmp + 1
	movl %edx, %eax
	shrl $2, %eax
	andl $1, %eax
	movb %al, _src_tmp + 2
	movl %edx, %eax
	shrl $3, %eax
	andl $1, %eax
	movb %al, _src_tmp + 3
	movl %edx, %eax
	shrl $4, %eax
	andl $1, %eax
	movb %al, _src_tmp + 4
	movl %edx, %eax
	shrl $5, %eax
	andl $1, %eax
	movb %al, _src_tmp + 5
	movl %edx, %eax
	shrl $6, %eax
	andl $1, %eax
	movb %al, _src_tmp + 6
	movl %edx, %eax
	shrl $7, %eax
	andl $1, %eax
	movb %al, _src_tmp + 7
	movl %edx, %eax
	shrl $8, %eax
	andl $1, %eax
	movb %al, _src_tmp + 8
	movl %edx, %eax
	shrl $9, %eax
	andl $1, %eax
	movb %al, _src_tmp + 9
	movl %edx, %eax
	shrl $10, %eax
	andl $1, %eax
	movb %al, _src_tmp + 10
	movl %edx, %eax
	shrl $11, %eax
	andl $1, %eax
	movb %al, _src_tmp + 11
	movl %edx, %eax
	shrl $12, %eax
	andl $1, %eax
	movb %al, _src_tmp + 12
	movl %edx, %eax
	shrl $13, %eax
	andl $1, %eax
	movb %al, _src_tmp + 13
	movl %edx, %eax
	shrl $14, %eax
	andl $1, %eax
	movb %al, _src_tmp + 14
	movl %edx, %eax
	shrl $15, %eax
	andl $1, %eax
	movb %al, _src_tmp + 15
	movl %edx, %eax
	shrl $16, %eax
	andl $1, %eax
	movb %al, _src_tmp + 16
	movl %edx, %eax
	shrl $17, %eax
	andl $1, %eax
	movb %al, _src_tmp + 17
	movl %edx, %eax
	shrl $18, %eax
	andl $1, %eax
	movb %al, _src_tmp + 18
	movl %edx, %eax
	shrl $19, %eax
	andl $1, %eax
	movb %al, _src_tmp + 19
	movl %edx, %eax
	shrl $20, %eax
	andl $1, %eax
	movb %al, _src_tmp + 20
	movl %edx, %eax
	shrl $21, %eax
	andl $1, %eax
	movb %al, _src_tmp + 21
	movl %edx, %eax
	shrl $22, %eax
	andl $1, %eax
	movb %al, _src_tmp + 22
	movl %edx, %eax
	shrl $23, %eax
	andl $1, %eax
	movb %al, _src_tmp + 23
	movl %edx, %eax
	shrl $24, %eax
	andl $1, %eax
	movb %al, _src_tmp + 24
	movl %edx, %eax
	shrl $25, %eax
	andl $1, %eax
	movb %al, _src_tmp + 25
	movl %edx, %eax
	shrl $26, %eax
	andl $1, %eax
	movb %al, _src_tmp + 26
	movl %edx, %eax
	shrl $27, %eax
	andl $1, %eax
	movb %al, _src_tmp + 27
	movl %edx, %eax
	shrl $28, %eax
	andl $1, %eax
	movb %al, _src_tmp + 28
	movl %edx, %eax
	shrl $29, %eax
	andl $1, %eax
	movb %al, _src_tmp + 29
	movl %edx, %eax
	shrl $30, %eax
	andl $1, %eax
	movb %al, _src_tmp + 30
	movl %edx, %eax
	shrl $31, %eax
	andl $1, %eax
	movb %al, _src_tmp + 31
	movl copy_eax, %edx
	movl %edx, %eax
	shrl $0, %eax
	andl $1, %eax
	movb %al, _eax + 0
	movl %edx, %eax
	shrl $1, %eax
	andl $1, %eax
	movb %al, _eax + 1
	movl %edx, %eax
	shrl $2, %eax
	andl $1, %eax
	movb %al, _eax + 2
	movl %edx, %eax
	shrl $3, %eax
	andl $1, %eax
	movb %al, _eax + 3
	movl %edx, %eax
	shrl $4, %eax
	andl $1, %eax
	movb %al, _eax + 4
	movl %edx, %eax
	shrl $5, %eax
	andl $1, %eax
	movb %al, _eax + 5
	movl %edx, %eax
	shrl $6, %eax
	andl $1, %eax
	movb %al, _eax + 6
	movl %edx, %eax
	shrl $7, %eax
	andl $1, %eax
	movb %al, _eax + 7
	movl %edx, %eax
	shrl $8, %eax
	andl $1, %eax
	movb %al, _eax + 8
	movl %edx, %eax
	shrl $9, %eax
	andl $1, %eax
	movb %al, _eax + 9
	movl %edx, %eax
	shrl $10, %eax
	andl $1, %eax
	movb %al, _eax + 10
	movl %edx, %eax
	shrl $11, %eax
	andl $1, %eax
	movb %al, _eax + 11
	movl %edx, %eax
	shrl $12, %eax
	andl $1, %eax
	movb %al, _eax + 12
	movl %edx, %eax
	shrl $13, %eax
	andl $1, %eax
	movb %al, _eax + 13
	movl %edx, %eax
	shrl $14, %eax
	andl $1, %eax
	movb %al, _eax + 14
	movl %edx, %eax
	shrl $15, %eax
	andl $1, %eax
	movb %al, _eax + 15
	movl %edx, %eax
	shrl $16, %eax
	andl $1, %eax
	movb %al, _eax + 16
	movl %edx, %eax
	shrl $17, %eax
	andl $1, %eax
	movb %al, _eax + 17
	movl %edx, %eax
	shrl $18, %eax
	andl $1, %eax
	movb %al, _eax + 18
	movl %edx, %eax
	shrl $19, %eax
	andl $1, %eax
	movb %al, _eax + 19
	movl %edx, %eax
	shrl $20, %eax
	andl $1, %eax
	movb %al, _eax + 20
	movl %edx, %eax
	shrl $21, %eax
	andl $1, %eax
	movb %al, _eax + 21
	movl %edx, %eax
	shrl $22, %eax
	andl $1, %eax
	movb %al, _eax + 22
	movl %edx, %eax
	shrl $23, %eax
	andl $1, %eax
	movb %al, _eax + 23
	movl %edx, %eax
	shrl $24, %eax
	andl $1, %eax
	movb %al, _eax + 24
	movl %edx, %eax
	shrl $25, %eax
	andl $1, %eax
	movb %al, _eax + 25
	movl %edx, %eax
	shrl $26, %eax
	andl $1, %eax
	movb %al, _eax + 26
	movl %edx, %eax
	shrl $27, %eax
	andl $1, %eax
	movb %al, _eax + 27
	movl %edx, %eax
	shrl $28, %eax
	andl $1, %eax
	movb %al, _eax + 28
	movl %edx, %eax
	shrl $29, %eax
	andl $1, %eax
	movb %al, _eax + 29
	movl %edx, %eax
	shrl $30, %eax
	andl $1, %eax
	movb %al, _eax + 30
	movl %edx, %eax
	shrl $31, %eax
	andl $1, %eax
	movb %al, _eax + 31
	movl $0, %ecx
	movzbl _eax + 0, %eax
	movzbl _src_tmp + 0, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 0, %eax
	movzbl _src_tmp + 0, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 0
	movzbl _eax + 1, %eax
	movzbl _src_tmp + 1, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 1, %eax
	movzbl _src_tmp + 1, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 1
	movzbl _eax + 2, %eax
	movzbl _src_tmp + 2, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 2, %eax
	movzbl _src_tmp + 2, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 2
	movzbl _eax + 3, %eax
	movzbl _src_tmp + 3, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 3, %eax
	movzbl _src_tmp + 3, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 3
	movzbl _eax + 4, %eax
	movzbl _src_tmp + 4, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 4, %eax
	movzbl _src_tmp + 4, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 4
	movzbl _eax + 5, %eax
	movzbl _src_tmp + 5, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 5, %eax
	movzbl _src_tmp + 5, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 5
	movzbl _eax + 6, %eax
	movzbl _src_tmp + 6, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 6, %eax
	movzbl _src_tmp + 6, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 6
	movzbl _eax + 7, %eax
	movzbl _src_tmp + 7, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 7, %eax
	movzbl _src_tmp + 7, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 7
	movzbl _eax + 8, %eax
	movzbl _src_tmp + 8, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 8, %eax
	movzbl _src_tmp + 8, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 8
	movzbl _eax + 9, %eax
	movzbl _src_tmp + 9, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 9, %eax
	movzbl _src_tmp + 9, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 9
	movzbl _eax + 10, %eax
	movzbl _src_tmp + 10, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 10, %eax
	movzbl _src_tmp + 10, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 10
	movzbl _eax + 11, %eax
	movzbl _src_tmp + 11, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 11, %eax
	movzbl _src_tmp + 11, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 11
	movzbl _eax + 12, %eax
	movzbl _src_tmp + 12, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 12, %eax
	movzbl _src_tmp + 12, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 12
	movzbl _eax + 13, %eax
	movzbl _src_tmp + 13, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 13, %eax
	movzbl _src_tmp + 13, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 13
	movzbl _eax + 14, %eax
	movzbl _src_tmp + 14, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 14, %eax
	movzbl _src_tmp + 14, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 14
	movzbl _eax + 15, %eax
	movzbl _src_tmp + 15, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 15, %eax
	movzbl _src_tmp + 15, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 15
	movzbl _eax + 16, %eax
	movzbl _src_tmp + 16, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 16, %eax
	movzbl _src_tmp + 16, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 16
	movzbl _eax + 17, %eax
	movzbl _src_tmp + 17, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 17, %eax
	movzbl _src_tmp + 17, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 17
	movzbl _eax + 18, %eax
	movzbl _src_tmp + 18, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 18, %eax
	movzbl _src_tmp + 18, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 18
	movzbl _eax + 19, %eax
	movzbl _src_tmp + 19, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 19, %eax
	movzbl _src_tmp + 19, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 19
	movzbl _eax + 20, %eax
	movzbl _src_tmp + 20, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 20, %eax
	movzbl _src_tmp + 20, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 20
	movzbl _eax + 21, %eax
	movzbl _src_tmp + 21, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 21, %eax
	movzbl _src_tmp + 21, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 21
	movzbl _eax + 22, %eax
	movzbl _src_tmp + 22, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 22, %eax
	movzbl _src_tmp + 22, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 22
	movzbl _eax + 23, %eax
	movzbl _src_tmp + 23, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 23, %eax
	movzbl _src_tmp + 23, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 23
	movzbl _eax + 24, %eax
	movzbl _src_tmp + 24, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 24, %eax
	movzbl _src_tmp + 24, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 24
	movzbl _eax + 25, %eax
	movzbl _src_tmp + 25, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 25, %eax
	movzbl _src_tmp + 25, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 25
	movzbl _eax + 26, %eax
	movzbl _src_tmp + 26, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 26, %eax
	movzbl _src_tmp + 26, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 26
	movzbl _eax + 27, %eax
	movzbl _src_tmp + 27, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 27, %eax
	movzbl _src_tmp + 27, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 27
	movzbl _eax + 28, %eax
	movzbl _src_tmp + 28, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 28, %eax
	movzbl _src_tmp + 28, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 28
	movzbl _eax + 29, %eax
	movzbl _src_tmp + 29, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 29, %eax
	movzbl _src_tmp + 29, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 29
	movzbl _eax + 30, %eax
	movzbl _src_tmp + 30, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 30, %eax
	movzbl _src_tmp + 30, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 30
	movzbl _eax + 31, %eax
	movzbl _src_tmp + 31, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl _eax + 31, %eax
	movzbl _src_tmp + 31, %ebx
	movl table_and(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %edx
	movl table_and(,%ebp,4), %edi
	movb (%edi, %esi, 1), %al
	movzbl %al, %eax
	movl table_or(,%edx,4), %edi
	movb (%edi, %eax, 1), %al
	movzbl %al, %ecx
	movl table_xor(,%esi,4), %edi
	movb (%edi, %ebp, 1), %al
	movb %al, _eax + 31
	movl $0, %edx
	movzbl _eax + 0, %eax
	shll $0, %eax
	orl %eax, %edx
	movzbl _eax + 1, %eax
	shll $1, %eax
	orl %eax, %edx
	movzbl _eax + 2, %eax
	shll $2, %eax
	orl %eax, %edx
	movzbl _eax + 3, %eax
	shll $3, %eax
	orl %eax, %edx
	movzbl _eax + 4, %eax
	shll $4, %eax
	orl %eax, %edx
	movzbl _eax + 5, %eax
	shll $5, %eax
	orl %eax, %edx
	movzbl _eax + 6, %eax
	shll $6, %eax
	orl %eax, %edx
	movzbl _eax + 7, %eax
	shll $7, %eax
	orl %eax, %edx
	movzbl _eax + 8, %eax
	shll $8, %eax
	orl %eax, %edx
	movzbl _eax + 9, %eax
	shll $9, %eax
	orl %eax, %edx
	movzbl _eax + 10, %eax
	shll $10, %eax
	orl %eax, %edx
	movzbl _eax + 11, %eax
	shll $11, %eax
	orl %eax, %edx
	movzbl _eax + 12, %eax
	shll $12, %eax
	orl %eax, %edx
	movzbl _eax + 13, %eax
	shll $13, %eax
	orl %eax, %edx
	movzbl _eax + 14, %eax
	shll $14, %eax
	orl %eax, %edx
	movzbl _eax + 15, %eax
	shll $15, %eax
	orl %eax, %edx
	movzbl _eax + 16, %eax
	shll $16, %eax
	orl %eax, %edx
	movzbl _eax + 17, %eax
	shll $17, %eax
	orl %eax, %edx
	movzbl _eax + 18, %eax
	shll $18, %eax
	orl %eax, %edx
	movzbl _eax + 19, %eax
	shll $19, %eax
	orl %eax, %edx
	movzbl _eax + 20, %eax
	shll $20, %eax
	orl %eax, %edx
	movzbl _eax + 21, %eax
	shll $21, %eax
	orl %eax, %edx
	movzbl _eax + 22, %eax
	shll $22, %eax
	orl %eax, %edx
	movzbl _eax + 23, %eax
	shll $23, %eax
	orl %eax, %edx
	movzbl _eax + 24, %eax
	shll $24, %eax
	orl %eax, %edx
	movzbl _eax + 25, %eax
	shll $25, %eax
	orl %eax, %edx
	movzbl _eax + 26, %eax
	shll $26, %eax
	orl %eax, %edx
	movzbl _eax + 27, %eax
	shll $27, %eax
	orl %eax, %edx
	movzbl _eax + 28, %eax
	shll $28, %eax
	orl %eax, %edx
	movzbl _eax + 29, %eax
	shll $29, %eax
	orl %eax, %edx
	movzbl _eax + 30, %eax
	shll $30, %eax
	orl %eax, %edx
	movzbl _eax + 31, %eax
	shll $31, %eax
	orl %eax, %edx
	pushl %edx
	movl copy_eax, %eax
	movl copy_ebx, %ebx
	movl copy_ecx, %ecx
	movl copy_edx, %edx
	movl copy_esi, %esi
	movl copy_edi, %edi
	movl copy_ebp, %ebp
	popl %eax

    pushl %eax
    pushl $printf_format
    call printf
    pop %eax
    pop %eax

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
