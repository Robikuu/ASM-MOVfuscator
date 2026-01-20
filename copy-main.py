fin = open("input.s", "r")
g = open("output.s", "w")

def complete_data():
    registers = ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp", "ebp"]
    
    for reg in registers:
        g.write(f"\tcopy_{reg}: .space 4\n")

    registers.pop(-1)
    registers.pop(-1)
    registers.append("src_tmp")
    for reg in registers:
        g.write(f"\t_{reg}: .byte {", ".join(["0"] * 32)}\n")

    g.write("\txor_row_0: .byte 0, 1\n")
    g.write("\txor_row_1: .byte 1, 0\n")
    g.write("\tand_row_0: .byte 0, 0\n")
    g.write("\tand_row_1: .byte 0, 1\n")
    g.write("\tor_row_0: .byte 0, 1\n")
    g.write("\tor_row_1: .byte 1, 1\n")
    g.write("\ttable_not: .byte 1, 0\n")
    g.write("\t.align 4\n\ttable_xor: .long xor_row_0, xor_row_1\n")
    g.write("\t.align 4\n\ttable_and: .long and_row_0, and_row_1\n")
    g.write("\t.align 4\n\ttable_or: .long or_row_0, or_row_1\n")
    g.write("\n.text\n")

def add(src, dest):
    # 1. Salvăm registrele originale
    used_regs = ["eax", "ebx", "ecx", "edx", "esi", "edi", "ebp"]
    for reg in used_regs:
        g.write(f"\tmovl %{reg}, copy_{reg}\n")

    src_label = "_src_tmp"
    dest_label = dest.replace("%", "_")
    
    # 2. Extragem biții din SURSĂ (src)
    if src.startswith("$"):
        val = src.replace("$", "")
        g.write(f"\tmovl ${val}, %edx\n")
    else:
        src_reg_name = src.replace("%", "")
        g.write(f"\tmovl copy_{src_reg_name}, %edx\n")

    for i in range(32):
        g.write(f"\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")
        g.write(f"\tandl $1, %eax\n")
        g.write(f"\tmovb %al, {src_label} + {i}\n")

    # 3. Extragem biții din DESTINAȚIE (dest)
    dest_reg_name = dest.replace("%", "")
    g.write(f"\tmovl copy_{dest_reg_name}, %edx\n")
    
    for i in range(32):
        g.write(f"\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")
        g.write(f"\tandl $1, %eax\n")
        g.write(f"\tmovb %al, {dest_label} + {i}\n")

    # 4. CALCULUL FULL ADDER
    g.write("\tmovl $0, %ecx\n") # Carry start = 0

    for i in range(32):
        # -- Citire operanzi --
        g.write(f"\tmovzbl {dest_label} + {i}, %eax\n") # A
        g.write(f"\tmovzbl {src_label} + {i}, %ebx\n")  # B
        g.write("\tmovl %ecx, %ebp\n") # Salvăm Carry vechi

        # -- Calcul A XOR B (Suma parțială) --
        g.write("\tmovl table_xor(,%eax,4), %edi\n")
        g.write("\tmovb (%edi, %ebx, 1), %al\n")
        g.write("\tmovzbl %al, %esi\n") # esi = A XOR B

        # -- Calcul CARRY NOU --
        # Formula: (A AND B) OR (Carry_vechi AND (A XOR B))
        
        # 1. (A AND B)
        g.write(f"\tmovzbl {dest_label} + {i}, %eax\n")
        g.write(f"\tmovzbl {src_label} + {i}, %ebx\n") # Re-citim pentru siguranță
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
        g.write("\tmovzbl %al, %ecx\n") # Carry actualizat în ECX

        # -- Calcul SUMA FINALA --
        # Formula: (A XOR B) XOR Carry_vechi
        g.write("\tmovl table_xor(,%esi,4), %edi\n")
        g.write("\tmovb (%edi, %ebp, 1), %al\n")
        g.write(f"\tmovb %al, {dest_label} + {i}\n")

    # 5. RECONSTRUCȚIA REGISTRULUI (Biți -> Număr)
    g.write("\tmovl $0, %edx\n") # Resetăm acumulatorul
    for i in range(32):
        g.write(f"\tmovzbl {dest_label} + {i}, %eax\n")
        # Metoda simplă și sigură: Shift Left
        g.write(f"\tshll ${i}, %eax\n") 
        g.write("\torl %eax, %edx\n")

    # 6. RESTAURAREA FINALĂ (SAFE RETURN)
    # Aici este corecția critică: Salvăm rezultatul pe stivă ca să nu fie suprascris
    g.write("\tpushl %edx\n") 

    # Restaurăm toate registrele la valorile lor originale
    for reg in used_regs:
        g.write(f"\tmovl copy_{reg}, %{reg}\n")

    # Recuperăm rezultatul de pe stivă și îl punem în destinația cerută
    # Dacă dest e registru (ex: %eax), pop direct în el
    if dest in ["%eax", "%ebx", "%ecx", "%edx", "%esi", "%edi", "%ebp"]:
        g.write(f"\tpopl {dest}\n")
    else:
        # Dacă dest e o variabilă din memorie
        g.write("\tpopl %eax\n")     # Scoatem în eax temporar
        g.write(f"\tmovl %eax, {dest}\n")

for line in fin:
    if line.startswith(".text"):
        complete_data()
    elif "add" in line:
        clean_line = line.split('#')[0].strip() 
        parts = clean_line.replace("addl", "").strip().split(",")
        if len(parts) == 2:
            src = parts[0].strip()
            dest = parts[1].strip()
            add(src, dest)
    else:
        g.write(line)
