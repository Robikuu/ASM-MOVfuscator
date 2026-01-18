# f = open("file.s", "r")
g = open("mov.s", "w")  # intentionat scris cu vv

def init():
    
    g.write(".data\n")
    g.write('\tscanf_format: .asciz "%d"\n')
    g.write('\tprintf_format: .asciz "%d\\n"\n\n')

    # xor
    g.write("\txor_row_0:\n\t\t.byte 0, 1\n")
    g.write("\txor_row_1:\n\t\t.byte 1, 0\n")
    g.write("\ttable_xor:\n\t\t.long xor_row_0\n\t\t.long xor_row_1\n\n")

    # and
    g.write("\tand_row_0:\n\t\t.byte 0, 0\n")
    g.write("\tand_row_1:\n\t\t.byte 0, 1\n")
    g.write("\ttable_and:\n\t\t.long and_row_0\n\t\t.long and_row_1\n\n")

    # or
    g.write("\tor_row_0:\n\t\t.byte 0, 1\n")
    g.write("\tor_row_1:\n\t\t.byte 1, 1\n")
    g.write("\ttable_or:\n\t\t.long or_row_0\n\t\t.long or_row_1\n\n")

    # not
    g.write("\ttable_not:\n\t\t.byte 1, 0\n\n")

    g.write(".text\n")
    g.write(".global main\n")
    g.write("main:\n")

init()
