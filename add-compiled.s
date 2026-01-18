.section .data
formatPrintf: .asciz "%d\n"
carry: .byte 0
temp_a: .byte 0
temp_b: .byte 0
temp_xor: .byte 0
temp_and1: .byte 0
temp_and2: .byte 0
input_x: .long 12
input_y: .long 5
result: .long 0
bits_x: .zero 32
bits_y: .zero 32
bits_res: .zero 32
xor_row_0: .byte 0, 1
xor_row_1: .byte 1, 0
xor_base: .long xor_row_0, xor_row_1
and_row_0: .byte 0, 0
and_row_1: .byte 0, 1
and_base: .long and_row_0, and_row_1
or_row_0: .byte 0, 1
or_row_1: .byte 1, 1
or_base: .long or_row_0, or_row_1
byte_split_table:
  .byte 0, 0, 0, 0, 0, 0, 0, 0
  .byte 1, 0, 0, 0, 0, 0, 0, 0
  .byte 0, 1, 0, 0, 0, 0, 0, 0
  .byte 1, 1, 0, 0, 0, 0, 0, 0
  .byte 0, 0, 1, 0, 0, 0, 0, 0
  .byte 1, 0, 1, 0, 0, 0, 0, 0
  .byte 0, 1, 1, 0, 0, 0, 0, 0
  .byte 1, 1, 1, 0, 0, 0, 0, 0
  .byte 0, 0, 0, 1, 0, 0, 0, 0
  .byte 1, 0, 0, 1, 0, 0, 0, 0
  .byte 0, 1, 0, 1, 0, 0, 0, 0
  .byte 1, 1, 0, 1, 0, 0, 0, 0
  .byte 0, 0, 1, 1, 0, 0, 0, 0
  .byte 1, 0, 1, 1, 0, 0, 0, 0
  .byte 0, 1, 1, 1, 0, 0, 0, 0
  .byte 1, 1, 1, 1, 0, 0, 0, 0
  .byte 0, 0, 0, 0, 1, 0, 0, 0
  .byte 1, 0, 0, 0, 1, 0, 0, 0
  .byte 0, 1, 0, 0, 1, 0, 0, 0
  .byte 1, 1, 0, 0, 1, 0, 0, 0
  .byte 0, 0, 1, 0, 1, 0, 0, 0
  .byte 1, 0, 1, 0, 1, 0, 0, 0
  .byte 0, 1, 1, 0, 1, 0, 0, 0
  .byte 1, 1, 1, 0, 1, 0, 0, 0
  .byte 0, 0, 0, 1, 1, 0, 0, 0
  .byte 1, 0, 0, 1, 1, 0, 0, 0
  .byte 0, 1, 0, 1, 1, 0, 0, 0
  .byte 1, 1, 0, 1, 1, 0, 0, 0
  .byte 0, 0, 1, 1, 1, 0, 0, 0
  .byte 1, 0, 1, 1, 1, 0, 0, 0
  .byte 0, 1, 1, 1, 1, 0, 0, 0
  .byte 1, 1, 1, 1, 1, 0, 0, 0
  .byte 0, 0, 0, 0, 0, 1, 0, 0
  .byte 1, 0, 0, 0, 0, 1, 0, 0
  .byte 0, 1, 0, 0, 0, 1, 0, 0
  .byte 1, 1, 0, 0, 0, 1, 0, 0
  .byte 0, 0, 1, 0, 0, 1, 0, 0
  .byte 1, 0, 1, 0, 0, 1, 0, 0
  .byte 0, 1, 1, 0, 0, 1, 0, 0
  .byte 1, 1, 1, 0, 0, 1, 0, 0
  .byte 0, 0, 0, 1, 0, 1, 0, 0
  .byte 1, 0, 0, 1, 0, 1, 0, 0
  .byte 0, 1, 0, 1, 0, 1, 0, 0
  .byte 1, 1, 0, 1, 0, 1, 0, 0
  .byte 0, 0, 1, 1, 0, 1, 0, 0
  .byte 1, 0, 1, 1, 0, 1, 0, 0
  .byte 0, 1, 1, 1, 0, 1, 0, 0
  .byte 1, 1, 1, 1, 0, 1, 0, 0
  .byte 0, 0, 0, 0, 1, 1, 0, 0
  .byte 1, 0, 0, 0, 1, 1, 0, 0
  .byte 0, 1, 0, 0, 1, 1, 0, 0
  .byte 1, 1, 0, 0, 1, 1, 0, 0
  .byte 0, 0, 1, 0, 1, 1, 0, 0
  .byte 1, 0, 1, 0, 1, 1, 0, 0
  .byte 0, 1, 1, 0, 1, 1, 0, 0
  .byte 1, 1, 1, 0, 1, 1, 0, 0
  .byte 0, 0, 0, 1, 1, 1, 0, 0
  .byte 1, 0, 0, 1, 1, 1, 0, 0
  .byte 0, 1, 0, 1, 1, 1, 0, 0
  .byte 1, 1, 0, 1, 1, 1, 0, 0
  .byte 0, 0, 1, 1, 1, 1, 0, 0
  .byte 1, 0, 1, 1, 1, 1, 0, 0
  .byte 0, 1, 1, 1, 1, 1, 0, 0
  .byte 1, 1, 1, 1, 1, 1, 0, 0
  .byte 0, 0, 0, 0, 0, 0, 1, 0
  .byte 1, 0, 0, 0, 0, 0, 1, 0
  .byte 0, 1, 0, 0, 0, 0, 1, 0
  .byte 1, 1, 0, 0, 0, 0, 1, 0
  .byte 0, 0, 1, 0, 0, 0, 1, 0
  .byte 1, 0, 1, 0, 0, 0, 1, 0
  .byte 0, 1, 1, 0, 0, 0, 1, 0
  .byte 1, 1, 1, 0, 0, 0, 1, 0
  .byte 0, 0, 0, 1, 0, 0, 1, 0
  .byte 1, 0, 0, 1, 0, 0, 1, 0
  .byte 0, 1, 0, 1, 0, 0, 1, 0
  .byte 1, 1, 0, 1, 0, 0, 1, 0
  .byte 0, 0, 1, 1, 0, 0, 1, 0
  .byte 1, 0, 1, 1, 0, 0, 1, 0
  .byte 0, 1, 1, 1, 0, 0, 1, 0
  .byte 1, 1, 1, 1, 0, 0, 1, 0
  .byte 0, 0, 0, 0, 1, 0, 1, 0
  .byte 1, 0, 0, 0, 1, 0, 1, 0
  .byte 0, 1, 0, 0, 1, 0, 1, 0
  .byte 1, 1, 0, 0, 1, 0, 1, 0
  .byte 0, 0, 1, 0, 1, 0, 1, 0
  .byte 1, 0, 1, 0, 1, 0, 1, 0
  .byte 0, 1, 1, 0, 1, 0, 1, 0
  .byte 1, 1, 1, 0, 1, 0, 1, 0
  .byte 0, 0, 0, 1, 1, 0, 1, 0
  .byte 1, 0, 0, 1, 1, 0, 1, 0
  .byte 0, 1, 0, 1, 1, 0, 1, 0
  .byte 1, 1, 0, 1, 1, 0, 1, 0
  .byte 0, 0, 1, 1, 1, 0, 1, 0
  .byte 1, 0, 1, 1, 1, 0, 1, 0
  .byte 0, 1, 1, 1, 1, 0, 1, 0
  .byte 1, 1, 1, 1, 1, 0, 1, 0
  .byte 0, 0, 0, 0, 0, 1, 1, 0
  .byte 1, 0, 0, 0, 0, 1, 1, 0
  .byte 0, 1, 0, 0, 0, 1, 1, 0
  .byte 1, 1, 0, 0, 0, 1, 1, 0
  .byte 0, 0, 1, 0, 0, 1, 1, 0
  .byte 1, 0, 1, 0, 0, 1, 1, 0
  .byte 0, 1, 1, 0, 0, 1, 1, 0
  .byte 1, 1, 1, 0, 0, 1, 1, 0
  .byte 0, 0, 0, 1, 0, 1, 1, 0
  .byte 1, 0, 0, 1, 0, 1, 1, 0
  .byte 0, 1, 0, 1, 0, 1, 1, 0
  .byte 1, 1, 0, 1, 0, 1, 1, 0
  .byte 0, 0, 1, 1, 0, 1, 1, 0
  .byte 1, 0, 1, 1, 0, 1, 1, 0
  .byte 0, 1, 1, 1, 0, 1, 1, 0
  .byte 1, 1, 1, 1, 0, 1, 1, 0
  .byte 0, 0, 0, 0, 1, 1, 1, 0
  .byte 1, 0, 0, 0, 1, 1, 1, 0
  .byte 0, 1, 0, 0, 1, 1, 1, 0
  .byte 1, 1, 0, 0, 1, 1, 1, 0
  .byte 0, 0, 1, 0, 1, 1, 1, 0
  .byte 1, 0, 1, 0, 1, 1, 1, 0
  .byte 0, 1, 1, 0, 1, 1, 1, 0
  .byte 1, 1, 1, 0, 1, 1, 1, 0
  .byte 0, 0, 0, 1, 1, 1, 1, 0
  .byte 1, 0, 0, 1, 1, 1, 1, 0
  .byte 0, 1, 0, 1, 1, 1, 1, 0
  .byte 1, 1, 0, 1, 1, 1, 1, 0
  .byte 0, 0, 1, 1, 1, 1, 1, 0
  .byte 1, 0, 1, 1, 1, 1, 1, 0
  .byte 0, 1, 1, 1, 1, 1, 1, 0
  .byte 1, 1, 1, 1, 1, 1, 1, 0
  .byte 0, 0, 0, 0, 0, 0, 0, 1
  .byte 1, 0, 0, 0, 0, 0, 0, 1
  .byte 0, 1, 0, 0, 0, 0, 0, 1
  .byte 1, 1, 0, 0, 0, 0, 0, 1
  .byte 0, 0, 1, 0, 0, 0, 0, 1
  .byte 1, 0, 1, 0, 0, 0, 0, 1
  .byte 0, 1, 1, 0, 0, 0, 0, 1
  .byte 1, 1, 1, 0, 0, 0, 0, 1
  .byte 0, 0, 0, 1, 0, 0, 0, 1
  .byte 1, 0, 0, 1, 0, 0, 0, 1
  .byte 0, 1, 0, 1, 0, 0, 0, 1
  .byte 1, 1, 0, 1, 0, 0, 0, 1
  .byte 0, 0, 1, 1, 0, 0, 0, 1
  .byte 1, 0, 1, 1, 0, 0, 0, 1
  .byte 0, 1, 1, 1, 0, 0, 0, 1
  .byte 1, 1, 1, 1, 0, 0, 0, 1
  .byte 0, 0, 0, 0, 1, 0, 0, 1
  .byte 1, 0, 0, 0, 1, 0, 0, 1
  .byte 0, 1, 0, 0, 1, 0, 0, 1
  .byte 1, 1, 0, 0, 1, 0, 0, 1
  .byte 0, 0, 1, 0, 1, 0, 0, 1
  .byte 1, 0, 1, 0, 1, 0, 0, 1
  .byte 0, 1, 1, 0, 1, 0, 0, 1
  .byte 1, 1, 1, 0, 1, 0, 0, 1
  .byte 0, 0, 0, 1, 1, 0, 0, 1
  .byte 1, 0, 0, 1, 1, 0, 0, 1
  .byte 0, 1, 0, 1, 1, 0, 0, 1
  .byte 1, 1, 0, 1, 1, 0, 0, 1
  .byte 0, 0, 1, 1, 1, 0, 0, 1
  .byte 1, 0, 1, 1, 1, 0, 0, 1
  .byte 0, 1, 1, 1, 1, 0, 0, 1
  .byte 1, 1, 1, 1, 1, 0, 0, 1
  .byte 0, 0, 0, 0, 0, 1, 0, 1
  .byte 1, 0, 0, 0, 0, 1, 0, 1
  .byte 0, 1, 0, 0, 0, 1, 0, 1
  .byte 1, 1, 0, 0, 0, 1, 0, 1
  .byte 0, 0, 1, 0, 0, 1, 0, 1
  .byte 1, 0, 1, 0, 0, 1, 0, 1
  .byte 0, 1, 1, 0, 0, 1, 0, 1
  .byte 1, 1, 1, 0, 0, 1, 0, 1
  .byte 0, 0, 0, 1, 0, 1, 0, 1
  .byte 1, 0, 0, 1, 0, 1, 0, 1
  .byte 0, 1, 0, 1, 0, 1, 0, 1
  .byte 1, 1, 0, 1, 0, 1, 0, 1
  .byte 0, 0, 1, 1, 0, 1, 0, 1
  .byte 1, 0, 1, 1, 0, 1, 0, 1
  .byte 0, 1, 1, 1, 0, 1, 0, 1
  .byte 1, 1, 1, 1, 0, 1, 0, 1
  .byte 0, 0, 0, 0, 1, 1, 0, 1
  .byte 1, 0, 0, 0, 1, 1, 0, 1
  .byte 0, 1, 0, 0, 1, 1, 0, 1
  .byte 1, 1, 0, 0, 1, 1, 0, 1
  .byte 0, 0, 1, 0, 1, 1, 0, 1
  .byte 1, 0, 1, 0, 1, 1, 0, 1
  .byte 0, 1, 1, 0, 1, 1, 0, 1
  .byte 1, 1, 1, 0, 1, 1, 0, 1
  .byte 0, 0, 0, 1, 1, 1, 0, 1
  .byte 1, 0, 0, 1, 1, 1, 0, 1
  .byte 0, 1, 0, 1, 1, 1, 0, 1
  .byte 1, 1, 0, 1, 1, 1, 0, 1
  .byte 0, 0, 1, 1, 1, 1, 0, 1
  .byte 1, 0, 1, 1, 1, 1, 0, 1
  .byte 0, 1, 1, 1, 1, 1, 0, 1
  .byte 1, 1, 1, 1, 1, 1, 0, 1
  .byte 0, 0, 0, 0, 0, 0, 1, 1
  .byte 1, 0, 0, 0, 0, 0, 1, 1
  .byte 0, 1, 0, 0, 0, 0, 1, 1
  .byte 1, 1, 0, 0, 0, 0, 1, 1
  .byte 0, 0, 1, 0, 0, 0, 1, 1
  .byte 1, 0, 1, 0, 0, 0, 1, 1
  .byte 0, 1, 1, 0, 0, 0, 1, 1
  .byte 1, 1, 1, 0, 0, 0, 1, 1
  .byte 0, 0, 0, 1, 0, 0, 1, 1
  .byte 1, 0, 0, 1, 0, 0, 1, 1
  .byte 0, 1, 0, 1, 0, 0, 1, 1
  .byte 1, 1, 0, 1, 0, 0, 1, 1
  .byte 0, 0, 1, 1, 0, 0, 1, 1
  .byte 1, 0, 1, 1, 0, 0, 1, 1
  .byte 0, 1, 1, 1, 0, 0, 1, 1
  .byte 1, 1, 1, 1, 0, 0, 1, 1
  .byte 0, 0, 0, 0, 1, 0, 1, 1
  .byte 1, 0, 0, 0, 1, 0, 1, 1
  .byte 0, 1, 0, 0, 1, 0, 1, 1
  .byte 1, 1, 0, 0, 1, 0, 1, 1
  .byte 0, 0, 1, 0, 1, 0, 1, 1
  .byte 1, 0, 1, 0, 1, 0, 1, 1
  .byte 0, 1, 1, 0, 1, 0, 1, 1
  .byte 1, 1, 1, 0, 1, 0, 1, 1
  .byte 0, 0, 0, 1, 1, 0, 1, 1
  .byte 1, 0, 0, 1, 1, 0, 1, 1
  .byte 0, 1, 0, 1, 1, 0, 1, 1
  .byte 1, 1, 0, 1, 1, 0, 1, 1
  .byte 0, 0, 1, 1, 1, 0, 1, 1
  .byte 1, 0, 1, 1, 1, 0, 1, 1
  .byte 0, 1, 1, 1, 1, 0, 1, 1
  .byte 1, 1, 1, 1, 1, 0, 1, 1
  .byte 0, 0, 0, 0, 0, 1, 1, 1
  .byte 1, 0, 0, 0, 0, 1, 1, 1
  .byte 0, 1, 0, 0, 0, 1, 1, 1
  .byte 1, 1, 0, 0, 0, 1, 1, 1
  .byte 0, 0, 1, 0, 0, 1, 1, 1
  .byte 1, 0, 1, 0, 0, 1, 1, 1
  .byte 0, 1, 1, 0, 0, 1, 1, 1
  .byte 1, 1, 1, 0, 0, 1, 1, 1
  .byte 0, 0, 0, 1, 0, 1, 1, 1
  .byte 1, 0, 0, 1, 0, 1, 1, 1
  .byte 0, 1, 0, 1, 0, 1, 1, 1
  .byte 1, 1, 0, 1, 0, 1, 1, 1
  .byte 0, 0, 1, 1, 0, 1, 1, 1
  .byte 1, 0, 1, 1, 0, 1, 1, 1
  .byte 0, 1, 1, 1, 0, 1, 1, 1
  .byte 1, 1, 1, 1, 0, 1, 1, 1
  .byte 0, 0, 0, 0, 1, 1, 1, 1
  .byte 1, 0, 0, 0, 1, 1, 1, 1
  .byte 0, 1, 0, 0, 1, 1, 1, 1
  .byte 1, 1, 0, 0, 1, 1, 1, 1
  .byte 0, 0, 1, 0, 1, 1, 1, 1
  .byte 1, 0, 1, 0, 1, 1, 1, 1
  .byte 0, 1, 1, 0, 1, 1, 1, 1
  .byte 1, 1, 1, 0, 1, 1, 1, 1
  .byte 0, 0, 0, 1, 1, 1, 1, 1
  .byte 1, 0, 0, 1, 1, 1, 1, 1
  .byte 0, 1, 0, 1, 1, 1, 1, 1
  .byte 1, 1, 0, 1, 1, 1, 1, 1
  .byte 0, 0, 1, 1, 1, 1, 1, 1
  .byte 1, 0, 1, 1, 1, 1, 1, 1
  .byte 0, 1, 1, 1, 1, 1, 1, 1
  .byte 1, 1, 1, 1, 1, 1, 1, 1

.section .text
.global main
main:

    # --- UNPACKING INPUTS (Explode) ---
    movb input_x+0, %al
    movzbl %al, %eax
    lea byte_split_table(,%eax,8), %ebx
    movb 0(%ebx), %al
    movb %al, bits_x+0
    movb 1(%ebx), %al
    movb %al, bits_x+1
    movb 2(%ebx), %al
    movb %al, bits_x+2
    movb 3(%ebx), %al
    movb %al, bits_x+3
    movb 4(%ebx), %al
    movb %al, bits_x+4
    movb 5(%ebx), %al
    movb %al, bits_x+5
    movb 6(%ebx), %al
    movb %al, bits_x+6
    movb 7(%ebx), %al
    movb %al, bits_x+7
    movb input_y+0, %al
    movzbl %al, %eax
    lea byte_split_table(,%eax,8), %ebx
    movb 0(%ebx), %al
    movb %al, bits_y+0
    movb 1(%ebx), %al
    movb %al, bits_y+1
    movb 2(%ebx), %al
    movb %al, bits_y+2
    movb 3(%ebx), %al
    movb %al, bits_y+3
    movb 4(%ebx), %al
    movb %al, bits_y+4
    movb 5(%ebx), %al
    movb %al, bits_y+5
    movb 6(%ebx), %al
    movb %al, bits_y+6
    movb 7(%ebx), %al
    movb %al, bits_y+7
    movb input_x+1, %al
    movzbl %al, %eax
    lea byte_split_table(,%eax,8), %ebx
    movb 0(%ebx), %al
    movb %al, bits_x+8
    movb 1(%ebx), %al
    movb %al, bits_x+9
    movb 2(%ebx), %al
    movb %al, bits_x+10
    movb 3(%ebx), %al
    movb %al, bits_x+11
    movb 4(%ebx), %al
    movb %al, bits_x+12
    movb 5(%ebx), %al
    movb %al, bits_x+13
    movb 6(%ebx), %al
    movb %al, bits_x+14
    movb 7(%ebx), %al
    movb %al, bits_x+15
    movb input_y+1, %al
    movzbl %al, %eax
    lea byte_split_table(,%eax,8), %ebx
    movb 0(%ebx), %al
    movb %al, bits_y+8
    movb 1(%ebx), %al
    movb %al, bits_y+9
    movb 2(%ebx), %al
    movb %al, bits_y+10
    movb 3(%ebx), %al
    movb %al, bits_y+11
    movb 4(%ebx), %al
    movb %al, bits_y+12
    movb 5(%ebx), %al
    movb %al, bits_y+13
    movb 6(%ebx), %al
    movb %al, bits_y+14
    movb 7(%ebx), %al
    movb %al, bits_y+15
    movb input_x+2, %al
    movzbl %al, %eax
    lea byte_split_table(,%eax,8), %ebx
    movb 0(%ebx), %al
    movb %al, bits_x+16
    movb 1(%ebx), %al
    movb %al, bits_x+17
    movb 2(%ebx), %al
    movb %al, bits_x+18
    movb 3(%ebx), %al
    movb %al, bits_x+19
    movb 4(%ebx), %al
    movb %al, bits_x+20
    movb 5(%ebx), %al
    movb %al, bits_x+21
    movb 6(%ebx), %al
    movb %al, bits_x+22
    movb 7(%ebx), %al
    movb %al, bits_x+23
    movb input_y+2, %al
    movzbl %al, %eax
    lea byte_split_table(,%eax,8), %ebx
    movb 0(%ebx), %al
    movb %al, bits_y+16
    movb 1(%ebx), %al
    movb %al, bits_y+17
    movb 2(%ebx), %al
    movb %al, bits_y+18
    movb 3(%ebx), %al
    movb %al, bits_y+19
    movb 4(%ebx), %al
    movb %al, bits_y+20
    movb 5(%ebx), %al
    movb %al, bits_y+21
    movb 6(%ebx), %al
    movb %al, bits_y+22
    movb 7(%ebx), %al
    movb %al, bits_y+23
    movb input_x+3, %al
    movzbl %al, %eax
    lea byte_split_table(,%eax,8), %ebx
    movb 0(%ebx), %al
    movb %al, bits_x+24
    movb 1(%ebx), %al
    movb %al, bits_x+25
    movb 2(%ebx), %al
    movb %al, bits_x+26
    movb 3(%ebx), %al
    movb %al, bits_x+27
    movb 4(%ebx), %al
    movb %al, bits_x+28
    movb 5(%ebx), %al
    movb %al, bits_x+29
    movb 6(%ebx), %al
    movb %al, bits_x+30
    movb 7(%ebx), %al
    movb %al, bits_x+31
    movb input_y+3, %al
    movzbl %al, %eax
    lea byte_split_table(,%eax,8), %ebx
    movb 0(%ebx), %al
    movb %al, bits_y+24
    movb 1(%ebx), %al
    movb %al, bits_y+25
    movb 2(%ebx), %al
    movb %al, bits_y+26
    movb 3(%ebx), %al
    movb %al, bits_y+27
    movb 4(%ebx), %al
    movb %al, bits_y+28
    movb 5(%ebx), %al
    movb %al, bits_y+29
    movb 6(%ebx), %al
    movb %al, bits_y+30
    movb 7(%ebx), %al
    movb %al, bits_y+31

    # --- START FULL ADDER CALCULATION ---
    movb $0, carry

    # --- BIT 0 ---
    # XOR (bits_x+0, bits_y+0) -> temp_xor
    movL bits_x+0, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+0, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+0
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+0
    # AND (bits_x+0, bits_y+0) -> temp_and1
    movL bits_x+0, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+0, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 1 ---
    # XOR (bits_x+1, bits_y+1) -> temp_xor
    movL bits_x+1, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+1, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+1
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+1
    # AND (bits_x+1, bits_y+1) -> temp_and1
    movL bits_x+1, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+1, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 2 ---
    # XOR (bits_x+2, bits_y+2) -> temp_xor
    movL bits_x+2, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+2
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+2
    # AND (bits_x+2, bits_y+2) -> temp_and1
    movL bits_x+2, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 3 ---
    # XOR (bits_x+3, bits_y+3) -> temp_xor
    movL bits_x+3, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+3, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+3
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+3
    # AND (bits_x+3, bits_y+3) -> temp_and1
    movL bits_x+3, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+3, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 4 ---
    # XOR (bits_x+4, bits_y+4) -> temp_xor
    movL bits_x+4, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+4, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+4
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+4
    # AND (bits_x+4, bits_y+4) -> temp_and1
    movL bits_x+4, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+4, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 5 ---
    # XOR (bits_x+5, bits_y+5) -> temp_xor
    movL bits_x+5, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+5, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+5
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+5
    # AND (bits_x+5, bits_y+5) -> temp_and1
    movL bits_x+5, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+5, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 6 ---
    # XOR (bits_x+6, bits_y+6) -> temp_xor
    movL bits_x+6, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+6, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+6
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+6
    # AND (bits_x+6, bits_y+6) -> temp_and1
    movL bits_x+6, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+6, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 7 ---
    # XOR (bits_x+7, bits_y+7) -> temp_xor
    movL bits_x+7, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+7, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+7
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+7
    # AND (bits_x+7, bits_y+7) -> temp_and1
    movL bits_x+7, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+7, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 8 ---
    # XOR (bits_x+8, bits_y+8) -> temp_xor
    movL bits_x+8, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+8, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+8
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+8
    # AND (bits_x+8, bits_y+8) -> temp_and1
    movL bits_x+8, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+8, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 9 ---
    # XOR (bits_x+9, bits_y+9) -> temp_xor
    movL bits_x+9, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+9, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+9
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+9
    # AND (bits_x+9, bits_y+9) -> temp_and1
    movL bits_x+9, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+9, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 10 ---
    # XOR (bits_x+10, bits_y+10) -> temp_xor
    movL bits_x+10, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+10, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+10
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+10
    # AND (bits_x+10, bits_y+10) -> temp_and1
    movL bits_x+10, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+10, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 11 ---
    # XOR (bits_x+11, bits_y+11) -> temp_xor
    movL bits_x+11, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+11, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+11
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+11
    # AND (bits_x+11, bits_y+11) -> temp_and1
    movL bits_x+11, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+11, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 12 ---
    # XOR (bits_x+12, bits_y+12) -> temp_xor
    movL bits_x+12, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+12, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+12
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+12
    # AND (bits_x+12, bits_y+12) -> temp_and1
    movL bits_x+12, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+12, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 13 ---
    # XOR (bits_x+13, bits_y+13) -> temp_xor
    movL bits_x+13, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+13, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+13
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+13
    # AND (bits_x+13, bits_y+13) -> temp_and1
    movL bits_x+13, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+13, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 14 ---
    # XOR (bits_x+14, bits_y+14) -> temp_xor
    movL bits_x+14, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+14, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+14
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+14
    # AND (bits_x+14, bits_y+14) -> temp_and1
    movL bits_x+14, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+14, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 15 ---
    # XOR (bits_x+15, bits_y+15) -> temp_xor
    movL bits_x+15, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+15, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+15
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+15
    # AND (bits_x+15, bits_y+15) -> temp_and1
    movL bits_x+15, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+15, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 16 ---
    # XOR (bits_x+16, bits_y+16) -> temp_xor
    movL bits_x+16, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+16, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+16
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+16
    # AND (bits_x+16, bits_y+16) -> temp_and1
    movL bits_x+16, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+16, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 17 ---
    # XOR (bits_x+17, bits_y+17) -> temp_xor
    movL bits_x+17, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+17, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+17
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+17
    # AND (bits_x+17, bits_y+17) -> temp_and1
    movL bits_x+17, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+17, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 18 ---
    # XOR (bits_x+18, bits_y+18) -> temp_xor
    movL bits_x+18, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+18, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+18
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+18
    # AND (bits_x+18, bits_y+18) -> temp_and1
    movL bits_x+18, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+18, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 19 ---
    # XOR (bits_x+19, bits_y+19) -> temp_xor
    movL bits_x+19, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+19, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+19
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+19
    # AND (bits_x+19, bits_y+19) -> temp_and1
    movL bits_x+19, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+19, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 20 ---
    # XOR (bits_x+20, bits_y+20) -> temp_xor
    movL bits_x+20, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+20, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+20
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+20
    # AND (bits_x+20, bits_y+20) -> temp_and1
    movL bits_x+20, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+20, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 21 ---
    # XOR (bits_x+21, bits_y+21) -> temp_xor
    movL bits_x+21, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+21, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+21
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+21
    # AND (bits_x+21, bits_y+21) -> temp_and1
    movL bits_x+21, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+21, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 22 ---
    # XOR (bits_x+22, bits_y+22) -> temp_xor
    movL bits_x+22, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+22, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+22
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+22
    # AND (bits_x+22, bits_y+22) -> temp_and1
    movL bits_x+22, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+22, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 23 ---
    # XOR (bits_x+23, bits_y+23) -> temp_xor
    movL bits_x+23, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+23, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+23
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+23
    # AND (bits_x+23, bits_y+23) -> temp_and1
    movL bits_x+23, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+23, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 24 ---
    # XOR (bits_x+24, bits_y+24) -> temp_xor
    movL bits_x+24, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+24, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+24
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+24
    # AND (bits_x+24, bits_y+24) -> temp_and1
    movL bits_x+24, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+24, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 25 ---
    # XOR (bits_x+25, bits_y+25) -> temp_xor
    movL bits_x+25, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+25, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+25
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+25
    # AND (bits_x+25, bits_y+25) -> temp_and1
    movL bits_x+25, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+25, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 26 ---
    # XOR (bits_x+26, bits_y+26) -> temp_xor
    movL bits_x+26, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+26, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+26
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+26
    # AND (bits_x+26, bits_y+26) -> temp_and1
    movL bits_x+26, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+26, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 27 ---
    # XOR (bits_x+27, bits_y+27) -> temp_xor
    movL bits_x+27, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+27, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+27
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+27
    # AND (bits_x+27, bits_y+27) -> temp_and1
    movL bits_x+27, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+27, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 28 ---
    # XOR (bits_x+28, bits_y+28) -> temp_xor
    movL bits_x+28, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+28, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+28
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+28
    # AND (bits_x+28, bits_y+28) -> temp_and1
    movL bits_x+28, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+28, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 29 ---
    # XOR (bits_x+29, bits_y+29) -> temp_xor
    movL bits_x+29, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+29, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+29
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+29
    # AND (bits_x+29, bits_y+29) -> temp_and1
    movL bits_x+29, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+29, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 30 ---
    # XOR (bits_x+30, bits_y+30) -> temp_xor
    movL bits_x+30, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+30, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+30
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+30
    # AND (bits_x+30, bits_y+30) -> temp_and1
    movL bits_x+30, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+30, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- BIT 31 ---
    # XOR (bits_x+31, bits_y+31) -> temp_xor
    movL bits_x+31, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL bits_y+31, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_xor
    # XOR (temp_xor, carry) -> bits_res+31
    movL temp_xor, %eax
    and $1, %eax
    movL xor_base(,%eax,4), %ebx
    movL carry, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, bits_res+31
    # AND (bits_x+31, bits_y+31) -> temp_and1
    movL bits_x+31, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL bits_y+31, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and1
    # AND (carry, temp_xor) -> temp_and2
    movL carry, %eax
    and $1, %eax
    movL and_base(,%eax,4), %ebx
    movL temp_xor, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, temp_and2
    # OR (temp_and1, temp_and2) -> carry
    movL temp_and1, %eax
    and $1, %eax
    movL or_base(,%eax,4), %ebx
    movL temp_and2, %ecx
    and $1, %ecx
    movb (%ebx, %ecx, 1), %al
    movb %al, carry

    # --- PACKING RESULT (Implode) ---
    xor %eax, %eax
    xor %ecx, %ecx
    movb bits_res+0, %bl
    and $1, %ebx
    shll $0, %ebx
    or %ebx, result
    movb bits_res+1, %bl
    and $1, %ebx
    shll $1, %ebx
    or %ebx, result
    movb bits_res+2, %bl
    and $1, %ebx
    shll $2, %ebx
    or %ebx, result
    movb bits_res+3, %bl
    and $1, %ebx
    shll $3, %ebx
    or %ebx, result
    movb bits_res+4, %bl
    and $1, %ebx
    shll $4, %ebx
    or %ebx, result
    movb bits_res+5, %bl
    and $1, %ebx
    shll $5, %ebx
    or %ebx, result
    movb bits_res+6, %bl
    and $1, %ebx
    shll $6, %ebx
    or %ebx, result
    movb bits_res+7, %bl
    and $1, %ebx
    shll $7, %ebx
    or %ebx, result
    movb bits_res+8, %bl
    and $1, %ebx
    shll $8, %ebx
    or %ebx, result
    movb bits_res+9, %bl
    and $1, %ebx
    shll $9, %ebx
    or %ebx, result
    movb bits_res+10, %bl
    and $1, %ebx
    shll $10, %ebx
    or %ebx, result
    movb bits_res+11, %bl
    and $1, %ebx
    shll $11, %ebx
    or %ebx, result
    movb bits_res+12, %bl
    and $1, %ebx
    shll $12, %ebx
    or %ebx, result
    movb bits_res+13, %bl
    and $1, %ebx
    shll $13, %ebx
    or %ebx, result
    movb bits_res+14, %bl
    and $1, %ebx
    shll $14, %ebx
    or %ebx, result
    movb bits_res+15, %bl
    and $1, %ebx
    shll $15, %ebx
    or %ebx, result
    movb bits_res+16, %bl
    and $1, %ebx
    shll $16, %ebx
    or %ebx, result
    movb bits_res+17, %bl
    and $1, %ebx
    shll $17, %ebx
    or %ebx, result
    movb bits_res+18, %bl
    and $1, %ebx
    shll $18, %ebx
    or %ebx, result
    movb bits_res+19, %bl
    and $1, %ebx
    shll $19, %ebx
    or %ebx, result
    movb bits_res+20, %bl
    and $1, %ebx
    shll $20, %ebx
    or %ebx, result
    movb bits_res+21, %bl
    and $1, %ebx
    shll $21, %ebx
    or %ebx, result
    movb bits_res+22, %bl
    and $1, %ebx
    shll $22, %ebx
    or %ebx, result
    movb bits_res+23, %bl
    and $1, %ebx
    shll $23, %ebx
    or %ebx, result
    movb bits_res+24, %bl
    and $1, %ebx
    shll $24, %ebx
    or %ebx, result
    movb bits_res+25, %bl
    and $1, %ebx
    shll $25, %ebx
    or %ebx, result
    movb bits_res+26, %bl
    and $1, %ebx
    shll $26, %ebx
    or %ebx, result
    movb bits_res+27, %bl
    and $1, %ebx
    shll $27, %ebx
    or %ebx, result
    movb bits_res+28, %bl
    and $1, %ebx
    shll $28, %ebx
    or %ebx, result
    movb bits_res+29, %bl
    and $1, %ebx
    shll $29, %ebx
    or %ebx, result
    movb bits_res+30, %bl
    and $1, %ebx
    shll $30, %ebx
    or %ebx, result
    movb bits_res+31, %bl
    and $1, %ebx
    shll $31, %ebx
    or %ebx, result

    push result
    push $formatPrintf
    call printf
    add $8, %esp

    # Exit
    mov $1, %eax
    mov $0, %ebx
    int $0x80
