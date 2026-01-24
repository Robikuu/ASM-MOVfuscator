g = open("output.s", "w")

def complete_data():
    registers = ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"]
    for reg in registers:
        g.write(f"\tcopy_{reg}: .space 4\n")

    g.write(f"\tsrc: .space 32\n")
    g.write(f"\tdest: .space 32\n")
    g.write("\txor_row_0: .byte 0, 1\n")
    g.write("\txor_row_1: .byte 1, 0\n")
    g.write("\tand_row_0: .byte 0, 0\n")
    g.write("\tand_row_1: .byte 0, 1\n")
    g.write("\tor_row_0: .byte 0, 1\n")
    g.write("\tor_row_1: .byte 1, 1\n")
    g.write("\ttable_not: .byte 1, 0\n")
    g.write("\t.align 4\n")
    g.write("\ttable_xor: .long xor_row_0, xor_row_1\n")
    g.write("\ttable_and: .long and_row_0, and_row_1\n")
    g.write("\ttable_or: .long or_row_0, or_row_1\n")
    g.write("\n.text\n")

def add(src, dest):
    registers = ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"]
    for reg in registers:
        g.write(f"\tmovl %{reg}, copy_{reg}\n")

    g.write(f"\tmovl {src}, %edx\n")
    for i in range(32):
        g.write(f"\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")
        g.write(f"\tandl $1, %eax\n")
        g.write(f"\tmovb %al, src + {i}\n")

    g.write(f"\tmovl copy_{dest[1:]}, %edx\n")
    for i in range(32):
        g.write(f"\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")
        g.write(f"\tandl $1, %eax\n")
        g.write(f"\tmovb %al, dest + {i}\n")
    
    g.write("\tmovl $0, %ecx\n")
    for i in range(32):
        # -- Citire operanzi din buffer-ele universale --
        g.write(f"\tmovzbl dest + {i}, %eax\n") # A
        g.write(f"\tmovzbl src + {i}, %ebx\n")  # B
        g.write("\tmovl %ecx, %ebp\n") # Salvăm Carry vechi

        # -- Calcul A XOR B --
        g.write("\tmovl table_xor(,%eax,4), %edi\n")
        g.write("\tmovb (%edi, %ebx, 1), %al\n")
        g.write("\tmovzbl %al, %esi\n") # esi = A XOR B

        # -- Calcul CARRY NOU --
        # 1. (A AND B)
        g.write(f"\tmovzbl dest + {i}, %eax\n")
        g.write(f"\tmovzbl src + {i}, %ebx\n") 
        g.write("\tmovl table_and(,%eax,4), %edi\n")
        g.write("\tmovb (%edi, %ebx, 1), %al\n")
        g.write("\tmovzbl %al, %edx\n") # edx = A AND B

        # 2. Carry_vechi AND (A XOR B)
        g.write("\tmovl table_and(,%ebp,4), %edi\n")
        g.write("\tmovb (%edi, %esi, 1), %al\n")
        g.write("\tmovzbl %al, %eax\n") 

        # 3. Final Carry = edx OR eax
        g.write("\tmovl table_or(,%edx,4), %edi\n")
        g.write("\tmovb (%edi, %eax, 1), %al\n")
        g.write("\tmovzbl %al, %ecx\n")

        # -- Calcul SUMA FINALA --
        g.write("\tmovl table_xor(,%esi,4), %edi\n")
        g.write("\tmovb (%edi, %ebp, 1), %al\n")
        g.write(f"\tmovb %al, dest + {i}\n")

    # 5. RECONSTRUCȚIA REGISTRULUI
    g.write("\tmovl $0, %edx\n")
    for i in range(32):
        g.write(f"\tmovzbl dest + {i}, %eax\n")
        g.write(f"\tshll ${i}, %eax\n") 
        g.write("\torl %eax, %edx\n")
    g.write(f"\tmovl %edx, {dest}\n")

    registers.remove(dest[1:])
    for reg in registers:
        g.write(f"\tmovl copy_{reg}, %{reg}\n")

def pop(dest):
    g.write(f"\tmovl 0(%esp), {dest}")
    add("$4", "%esp")
    
def sub(src, dest):
    not_function(src)
    add("$1",src)
    add(src,dest)
    
def inc(src):
    add("$1",src)
    
def dec(src):
    add("$-1",src)
    
def loop(src):
    jmp(src)

    dec("%ecx")

def operatori_logici(src, dest, table_name):
    dest= dest.replace("%", "").strip()
    registers = ["eax","ebx", "edx", "edi"]
    for r in registers:
        g.write(f"\tmovl %{r}, copy_{r}\n")
        
    g.write(f"\tmovl {src}, %edx\n")
    for i in range(32):
        g.write("\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")
        g.write("\tandl $1, %eax\n")
        g.write(f"\tmovb %al, src+{i}\n")
    
    g.write(f"\tmovl copy_{dest}, %edx\n")
    for i in range(32):
        g.write("\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")
        g.write("\tandl $1, %eax\n")
        g.write(f"\tmovb %al, dest+{i}\n")

    for i in range(32):
        g.write(f"\tmovzbl dest+{i}, %eax\n")
        g.write(f"\tmovzbl src+{i}, %ebx\n")
        g.write(f"\tmovl {table_name}(,%eax,4), %edi\n")
        g.write("\tmovb (%edi,%ebx,1), %al\n")
        g.write(f"\tmovb %al, dest+{i}\n")
    
    g.write("\tmovl $0, %edx\n")
    for i in range(32):
        g.write(f"\tmovzbl dest+{i}, %eax\n")
        g.write(f"\tshll ${i}, %eax\n")
        g.write("\torl %eax, %edx\n")
        
    g.write(f"\tmovl %edx, %{dest}\n")
    for r in registers:
        if dest!=r:
            g.write(f"\tmovl copy_{r}, %{r}\n")


def not_operator(dest):
    dest= dest.replace("%", "").strip()
    g.write("\tmovl %eax, copy_eax\n")
    g.write("\tmovl %edx, copy_edx\n")
    g.write(f"\tmovl %{dest}, %edx\n")
    for i in range(32):
        g.write(f"\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")
        g.write(f"\tandl $1, %eax\n")
        g.write(f"\tmovb %al, dest + {i}\n")

    for i in range(32):
        g.write(f"\tmovzbl dest+{i}, %eax\n")
        g.write(f"\tmovb table_not(%eax), %al\n")
        g.write(f"\tmovb %al, dest+{i}\n")
    
    g.write("\tmovl $0, %edx\n")
    for i in range(32):
        g.write(f"\tmovzbl dest+{i}, %eax\n")
        g.write(f"\tshll ${i}, %eax\n")
        g.write("\torl %eax, %edx\n")
    
    g.write(f"\tmovl %edx, %{dest}\n")
    if dest != "eax":
        g.write("\tmovl copy_eax, %eax\n")
    if  dest !="edx":
        g.write("\tmovl copy_edx, %edx\n")

def lea_operator(base,dest):
    base=base.replace(" ", "")
    if '(' in base:
        offset = base.split('(')[0].strip()
        base = base.split('(')[1].replace(')', '').strip()
        if "%" not in base: 
            base = f"%{base}"
            
        g.write(f"\tmovl {base}, {dest}\n")
        
        if offset!='0' and offset:
            add(f"${offset}", dest)
    else:
        g.write(f"\tmovl ${base}, {dest}\n")
