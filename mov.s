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
