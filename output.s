.data
    x: .long -32
    y: .long -16
    printf_format: .asciz "%d\n"

	copy_eax: .space 4
	copy_ebx: .space 4
	copy_ecx: .space 4
	copy_edx: .space 4
	copy_esi: .space 4
	copy_edi: .space 4
	copy_esp: .space 4
	copy_ebp: .space 4
	src: .space 32
	dest: .space 32
	xor_row_0: .byte 0, 1
	xor_row_1: .byte 1, 0
	and_row_0: .byte 0, 0
	and_row_1: .byte 0, 1
	or_row_0: .byte 0, 1
	or_row_1: .byte 1, 1
	table_not: .byte 1, 0
	.align 4
	table_xor: .long xor_row_0, xor_row_1
	table_and: .long and_row_0, and_row_1
	table_or: .long or_row_0, or_row_1

.text

.global main

main:
    movl x, %ecx
    movl y, %edx
	movl %eax, copy_eax
	movl %ebx, copy_ebx
	movl %ecx, copy_ecx
	movl %edx, copy_edx
	movl %esi, copy_esi
	movl %edi, copy_edi
	movl %ebp, copy_ebp
	movl %ecx, %edx
	movl %edx, %eax
	shrl $0, %eax
	andl $1, %eax
	movb %al, src + 0
	movl %edx, %eax
	shrl $1, %eax
	andl $1, %eax
	movb %al, src + 1
	movl %edx, %eax
	shrl $2, %eax
	andl $1, %eax
	movb %al, src + 2
	movl %edx, %eax
	shrl $3, %eax
	andl $1, %eax
	movb %al, src + 3
	movl %edx, %eax
	shrl $4, %eax
	andl $1, %eax
	movb %al, src + 4
	movl %edx, %eax
	shrl $5, %eax
	andl $1, %eax
	movb %al, src + 5
	movl %edx, %eax
	shrl $6, %eax
	andl $1, %eax
	movb %al, src + 6
	movl %edx, %eax
	shrl $7, %eax
	andl $1, %eax
	movb %al, src + 7
	movl %edx, %eax
	shrl $8, %eax
	andl $1, %eax
	movb %al, src + 8
	movl %edx, %eax
	shrl $9, %eax
	andl $1, %eax
	movb %al, src + 9
	movl %edx, %eax
	shrl $10, %eax
	andl $1, %eax
	movb %al, src + 10
	movl %edx, %eax
	shrl $11, %eax
	andl $1, %eax
	movb %al, src + 11
	movl %edx, %eax
	shrl $12, %eax
	andl $1, %eax
	movb %al, src + 12
	movl %edx, %eax
	shrl $13, %eax
	andl $1, %eax
	movb %al, src + 13
	movl %edx, %eax
	shrl $14, %eax
	andl $1, %eax
	movb %al, src + 14
	movl %edx, %eax
	shrl $15, %eax
	andl $1, %eax
	movb %al, src + 15
	movl %edx, %eax
	shrl $16, %eax
	andl $1, %eax
	movb %al, src + 16
	movl %edx, %eax
	shrl $17, %eax
	andl $1, %eax
	movb %al, src + 17
	movl %edx, %eax
	shrl $18, %eax
	andl $1, %eax
	movb %al, src + 18
	movl %edx, %eax
	shrl $19, %eax
	andl $1, %eax
	movb %al, src + 19
	movl %edx, %eax
	shrl $20, %eax
	andl $1, %eax
	movb %al, src + 20
	movl %edx, %eax
	shrl $21, %eax
	andl $1, %eax
	movb %al, src + 21
	movl %edx, %eax
	shrl $22, %eax
	andl $1, %eax
	movb %al, src + 22
	movl %edx, %eax
	shrl $23, %eax
	andl $1, %eax
	movb %al, src + 23
	movl %edx, %eax
	shrl $24, %eax
	andl $1, %eax
	movb %al, src + 24
	movl %edx, %eax
	shrl $25, %eax
	andl $1, %eax
	movb %al, src + 25
	movl %edx, %eax
	shrl $26, %eax
	andl $1, %eax
	movb %al, src + 26
	movl %edx, %eax
	shrl $27, %eax
	andl $1, %eax
	movb %al, src + 27
	movl %edx, %eax
	shrl $28, %eax
	andl $1, %eax
	movb %al, src + 28
	movl %edx, %eax
	shrl $29, %eax
	andl $1, %eax
	movb %al, src + 29
	movl %edx, %eax
	shrl $30, %eax
	andl $1, %eax
	movb %al, src + 30
	movl %edx, %eax
	shrl $31, %eax
	andl $1, %eax
	movb %al, src + 31
	movl copy_edx, %edx
	movl %edx, %eax
	shrl $0, %eax
	andl $1, %eax
	movb %al, dest + 0
	movl %edx, %eax
	shrl $1, %eax
	andl $1, %eax
	movb %al, dest + 1
	movl %edx, %eax
	shrl $2, %eax
	andl $1, %eax
	movb %al, dest + 2
	movl %edx, %eax
	shrl $3, %eax
	andl $1, %eax
	movb %al, dest + 3
	movl %edx, %eax
	shrl $4, %eax
	andl $1, %eax
	movb %al, dest + 4
	movl %edx, %eax
	shrl $5, %eax
	andl $1, %eax
	movb %al, dest + 5
	movl %edx, %eax
	shrl $6, %eax
	andl $1, %eax
	movb %al, dest + 6
	movl %edx, %eax
	shrl $7, %eax
	andl $1, %eax
	movb %al, dest + 7
	movl %edx, %eax
	shrl $8, %eax
	andl $1, %eax
	movb %al, dest + 8
	movl %edx, %eax
	shrl $9, %eax
	andl $1, %eax
	movb %al, dest + 9
	movl %edx, %eax
	shrl $10, %eax
	andl $1, %eax
	movb %al, dest + 10
	movl %edx, %eax
	shrl $11, %eax
	andl $1, %eax
	movb %al, dest + 11
	movl %edx, %eax
	shrl $12, %eax
	andl $1, %eax
	movb %al, dest + 12
	movl %edx, %eax
	shrl $13, %eax
	andl $1, %eax
	movb %al, dest + 13
	movl %edx, %eax
	shrl $14, %eax
	andl $1, %eax
	movb %al, dest + 14
	movl %edx, %eax
	shrl $15, %eax
	andl $1, %eax
	movb %al, dest + 15
	movl %edx, %eax
	shrl $16, %eax
	andl $1, %eax
	movb %al, dest + 16
	movl %edx, %eax
	shrl $17, %eax
	andl $1, %eax
	movb %al, dest + 17
	movl %edx, %eax
	shrl $18, %eax
	andl $1, %eax
	movb %al, dest + 18
	movl %edx, %eax
	shrl $19, %eax
	andl $1, %eax
	movb %al, dest + 19
	movl %edx, %eax
	shrl $20, %eax
	andl $1, %eax
	movb %al, dest + 20
	movl %edx, %eax
	shrl $21, %eax
	andl $1, %eax
	movb %al, dest + 21
	movl %edx, %eax
	shrl $22, %eax
	andl $1, %eax
	movb %al, dest + 22
	movl %edx, %eax
	shrl $23, %eax
	andl $1, %eax
	movb %al, dest + 23
	movl %edx, %eax
	shrl $24, %eax
	andl $1, %eax
	movb %al, dest + 24
	movl %edx, %eax
	shrl $25, %eax
	andl $1, %eax
	movb %al, dest + 25
	movl %edx, %eax
	shrl $26, %eax
	andl $1, %eax
	movb %al, dest + 26
	movl %edx, %eax
	shrl $27, %eax
	andl $1, %eax
	movb %al, dest + 27
	movl %edx, %eax
	shrl $28, %eax
	andl $1, %eax
	movb %al, dest + 28
	movl %edx, %eax
	shrl $29, %eax
	andl $1, %eax
	movb %al, dest + 29
	movl %edx, %eax
	shrl $30, %eax
	andl $1, %eax
	movb %al, dest + 30
	movl %edx, %eax
	shrl $31, %eax
	andl $1, %eax
	movb %al, dest + 31
	movl $0, %ecx
	movzbl dest + 0, %eax
	movzbl src + 0, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 0, %eax
	movzbl src + 0, %ebx
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
	movb %al, dest + 0
	movzbl dest + 1, %eax
	movzbl src + 1, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 1, %eax
	movzbl src + 1, %ebx
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
	movb %al, dest + 1
	movzbl dest + 2, %eax
	movzbl src + 2, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 2, %eax
	movzbl src + 2, %ebx
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
	movb %al, dest + 2
	movzbl dest + 3, %eax
	movzbl src + 3, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 3, %eax
	movzbl src + 3, %ebx
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
	movb %al, dest + 3
	movzbl dest + 4, %eax
	movzbl src + 4, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 4, %eax
	movzbl src + 4, %ebx
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
	movb %al, dest + 4
	movzbl dest + 5, %eax
	movzbl src + 5, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 5, %eax
	movzbl src + 5, %ebx
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
	movb %al, dest + 5
	movzbl dest + 6, %eax
	movzbl src + 6, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 6, %eax
	movzbl src + 6, %ebx
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
	movb %al, dest + 6
	movzbl dest + 7, %eax
	movzbl src + 7, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 7, %eax
	movzbl src + 7, %ebx
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
	movb %al, dest + 7
	movzbl dest + 8, %eax
	movzbl src + 8, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 8, %eax
	movzbl src + 8, %ebx
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
	movb %al, dest + 8
	movzbl dest + 9, %eax
	movzbl src + 9, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 9, %eax
	movzbl src + 9, %ebx
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
	movb %al, dest + 9
	movzbl dest + 10, %eax
	movzbl src + 10, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 10, %eax
	movzbl src + 10, %ebx
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
	movb %al, dest + 10
	movzbl dest + 11, %eax
	movzbl src + 11, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 11, %eax
	movzbl src + 11, %ebx
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
	movb %al, dest + 11
	movzbl dest + 12, %eax
	movzbl src + 12, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 12, %eax
	movzbl src + 12, %ebx
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
	movb %al, dest + 12
	movzbl dest + 13, %eax
	movzbl src + 13, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 13, %eax
	movzbl src + 13, %ebx
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
	movb %al, dest + 13
	movzbl dest + 14, %eax
	movzbl src + 14, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 14, %eax
	movzbl src + 14, %ebx
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
	movb %al, dest + 14
	movzbl dest + 15, %eax
	movzbl src + 15, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 15, %eax
	movzbl src + 15, %ebx
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
	movb %al, dest + 15
	movzbl dest + 16, %eax
	movzbl src + 16, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 16, %eax
	movzbl src + 16, %ebx
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
	movb %al, dest + 16
	movzbl dest + 17, %eax
	movzbl src + 17, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 17, %eax
	movzbl src + 17, %ebx
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
	movb %al, dest + 17
	movzbl dest + 18, %eax
	movzbl src + 18, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 18, %eax
	movzbl src + 18, %ebx
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
	movb %al, dest + 18
	movzbl dest + 19, %eax
	movzbl src + 19, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 19, %eax
	movzbl src + 19, %ebx
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
	movb %al, dest + 19
	movzbl dest + 20, %eax
	movzbl src + 20, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 20, %eax
	movzbl src + 20, %ebx
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
	movb %al, dest + 20
	movzbl dest + 21, %eax
	movzbl src + 21, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 21, %eax
	movzbl src + 21, %ebx
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
	movb %al, dest + 21
	movzbl dest + 22, %eax
	movzbl src + 22, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 22, %eax
	movzbl src + 22, %ebx
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
	movb %al, dest + 22
	movzbl dest + 23, %eax
	movzbl src + 23, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 23, %eax
	movzbl src + 23, %ebx
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
	movb %al, dest + 23
	movzbl dest + 24, %eax
	movzbl src + 24, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 24, %eax
	movzbl src + 24, %ebx
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
	movb %al, dest + 24
	movzbl dest + 25, %eax
	movzbl src + 25, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 25, %eax
	movzbl src + 25, %ebx
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
	movb %al, dest + 25
	movzbl dest + 26, %eax
	movzbl src + 26, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 26, %eax
	movzbl src + 26, %ebx
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
	movb %al, dest + 26
	movzbl dest + 27, %eax
	movzbl src + 27, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 27, %eax
	movzbl src + 27, %ebx
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
	movb %al, dest + 27
	movzbl dest + 28, %eax
	movzbl src + 28, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 28, %eax
	movzbl src + 28, %ebx
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
	movb %al, dest + 28
	movzbl dest + 29, %eax
	movzbl src + 29, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 29, %eax
	movzbl src + 29, %ebx
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
	movb %al, dest + 29
	movzbl dest + 30, %eax
	movzbl src + 30, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 30, %eax
	movzbl src + 30, %ebx
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
	movb %al, dest + 30
	movzbl dest + 31, %eax
	movzbl src + 31, %ebx
	movl %ecx, %ebp
	movl table_xor(,%eax,4), %edi
	movb (%edi, %ebx, 1), %al
	movzbl %al, %esi
	movzbl dest + 31, %eax
	movzbl src + 31, %ebx
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
	movb %al, dest + 31
	movl $0, %edx
	movzbl dest + 0, %eax
	shll $0, %eax
	orl %eax, %edx
	movzbl dest + 1, %eax
	shll $1, %eax
	orl %eax, %edx
	movzbl dest + 2, %eax
	shll $2, %eax
	orl %eax, %edx
	movzbl dest + 3, %eax
	shll $3, %eax
	orl %eax, %edx
	movzbl dest + 4, %eax
	shll $4, %eax
	orl %eax, %edx
	movzbl dest + 5, %eax
	shll $5, %eax
	orl %eax, %edx
	movzbl dest + 6, %eax
	shll $6, %eax
	orl %eax, %edx
	movzbl dest + 7, %eax
	shll $7, %eax
	orl %eax, %edx
	movzbl dest + 8, %eax
	shll $8, %eax
	orl %eax, %edx
	movzbl dest + 9, %eax
	shll $9, %eax
	orl %eax, %edx
	movzbl dest + 10, %eax
	shll $10, %eax
	orl %eax, %edx
	movzbl dest + 11, %eax
	shll $11, %eax
	orl %eax, %edx
	movzbl dest + 12, %eax
	shll $12, %eax
	orl %eax, %edx
	movzbl dest + 13, %eax
	shll $13, %eax
	orl %eax, %edx
	movzbl dest + 14, %eax
	shll $14, %eax
	orl %eax, %edx
	movzbl dest + 15, %eax
	shll $15, %eax
	orl %eax, %edx
	movzbl dest + 16, %eax
	shll $16, %eax
	orl %eax, %edx
	movzbl dest + 17, %eax
	shll $17, %eax
	orl %eax, %edx
	movzbl dest + 18, %eax
	shll $18, %eax
	orl %eax, %edx
	movzbl dest + 19, %eax
	shll $19, %eax
	orl %eax, %edx
	movzbl dest + 20, %eax
	shll $20, %eax
	orl %eax, %edx
	movzbl dest + 21, %eax
	shll $21, %eax
	orl %eax, %edx
	movzbl dest + 22, %eax
	shll $22, %eax
	orl %eax, %edx
	movzbl dest + 23, %eax
	shll $23, %eax
	orl %eax, %edx
	movzbl dest + 24, %eax
	shll $24, %eax
	orl %eax, %edx
	movzbl dest + 25, %eax
	shll $25, %eax
	orl %eax, %edx
	movzbl dest + 26, %eax
	shll $26, %eax
	orl %eax, %edx
	movzbl dest + 27, %eax
	shll $27, %eax
	orl %eax, %edx
	movzbl dest + 28, %eax
	shll $28, %eax
	orl %eax, %edx
	movzbl dest + 29, %eax
	shll $29, %eax
	orl %eax, %edx
	movzbl dest + 30, %eax
	shll $30, %eax
	orl %eax, %edx
	movzbl dest + 31, %eax
	shll $31, %eax
	orl %eax, %edx
	movl %edx, %edx
	movl copy_eax, %eax
	movl copy_ebx, %ebx
	movl copy_ecx, %ecx
	movl copy_esi, %esi
	movl copy_edi, %edi
	movl copy_ebp, %ebp

    pushl %edx
    pushl $printf_format
    call printf
    pop %eax
    pop %eax

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
