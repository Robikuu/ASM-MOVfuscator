g = None

def init(filename):
    global g
    g = open(filename, "w")

def close():
    global g
    if g:
        g.close()
        
def complete_data():
    registers = ["eax", "ebx", "ecx", "edx", "esi", "edi", "ebp", "esp"]
    for reg in registers:
        g.write(f"\tcopy_{reg}: .space 4\n")
        g.write(f"\tcopy1_{reg}: .space 4\n")
        g.write(f"\tcopy2_{reg}: .space 4\n")

    g.write("\tcopy3_ecx: .space 4\n")
    g.write("\told_carry: .space 4\n")
    g.write("\tsrc_op: .space 4\n")
    g.write("\tsrc_sub: .space 4\n")
    g.write(f"\tsrc: .space 32\n")
    g.write(f"\tdest: .space 32\n")
    g.write("\txor_row_0: .byte 0, 1\n")
    g.write("\txor_row_1: .byte 1, 0\n")
    g.write("\ttable_not: .byte 1, 0\n")
    
    for i in range(256):
        row_vals = ", ".join([str(i & j) for j in range(256)])
        g.write(f"\tand_row_{i}: .byte {row_vals}\n")
    
    for i in range(256):
        row_vals = ", ".join([str(i | j) for j in range(256)])
        g.write(f"\tor_row_{i}: .byte {row_vals}\n")

    g.write("\t.align 4\n")
    g.write("\ttable_and: .long " + ", ".join([f"and_row_{i}" for i in range(256)]) + "\n")
    g.write("\ttable_or: .long " + ", ".join([f"or_row_{i}" for i in range(256)]) + "\n")
    g.write("\ttable_xor: .long xor_row_0, xor_row_1\n") # Pastrat pentru compatibilitate cu xor vechi
    g.write("\n.text\n")

def and_op(src, dest):
    g.write("\tmovl %ebp, copy1_ebp\n")
    registers = ["eax", "ebx", "ecx", "edx", "esi", "edi"]
    for reg in registers:
        g.write(f"\tmovl copy_{reg}, %ebp\n")
        g.write(f"\tmovl %ebp, copy1_{reg}\n")
        g.write(f"\tmovl %{reg}, copy_{reg}\n")

    g.write("\tmovl $0, %ecx\n")
    g.write(f"\tmovl {src}, src_op\n")
    # vom lua cei 4 bytes in ordine inversa pentru a fi mai usor sa concatenam rezultatele
    # extragem byte-ul 3
    g.write(f"\tmovl src_op, %ebx\n")
    g.write("\tshrl $24, %ebx\n") # ebx = col
    g.write(f"\tmovl copy_{dest[1:]}, %eax\n")
    g.write("\tshrl $24, %eax\n") # eax = row
    g.write("\tmovl table_and(,%eax,4), %edi\n")
    g.write("\tmovb (%edi, %ebx, 1), %al\n") # al = valoarea din lookup table

    g.write("\tmovb %al, %cl\n")
    g.write("\tshll $8, %ecx\n")

    # extragem byte-ul 2
    g.write(f"\tmovl src_op, %ebx\n")
    g.write("\tshrl $16, %ebx\n")
    g.write("\tmovzbl %bl, %ebx\n")
    g.write(f"\tmovl copy_{dest[1:]}, %eax\n")
    g.write("\tshrl $16, %eax\n")
    g.write("\tmovzbl %al, %eax\n")
    g.write("\tmovl table_and(,%eax,4), %edi\n")
    g.write("\tmovb (%edi, %ebx, 1), %al\n")

    g.write("\tmovb %al, %cl\n")
    g.write("\tshll $8, %ecx\n")

    # extragem byte-ul 1
    g.write(f"\tmovl src_op, %ebx\n")
    g.write("\tshrl $8, %ebx\n")
    g.write("\tmovzbl %bl, %ebx\n")
    g.write(f"\tmovl copy_{dest[1:]}, %eax\n")
    g.write("\tshrl $8, %eax\n")
    g.write("\tmovzbl %al, %eax\n")
    g.write("\tmovl table_and(,%eax,4), %edi\n")
    g.write("\tmovb (%edi, %ebx, 1), %al\n")

    g.write("\tmovb %al, %cl\n")
    g.write("\tshll $8, %ecx\n")

    # extragem byte-ul 0
    g.write(f"\tmovl src_op, %ebx\n")
    g.write("\tmovzbl %bl, %ebx\n")
    g.write(f"\tmovl copy_{dest[1:]}, %eax\n")
    g.write("\tmovzbl %al, %eax\n")
    g.write("\tmovl table_and(,%eax,4), %edi\n")
    g.write("\tmovb (%edi, %ebx, 1), %al\n")

    g.write("\tmovb %al, %cl\n")

    g.write(f"\tmovl %ecx, %{dest[1:]}\n")
    
    # restaurarea registrilor
    for reg in registers:
        if reg != dest[1:]:
            g.write(f"\tmovl copy_{reg}, %{reg}\n")

    for reg in registers:
        g.write(f"\tmovl copy1_{reg}, %ebp\n")
        g.write(f"\tmovl %ebp, copy_{reg}\n")
    g.write("\tmovl copy1_ebp, %ebp\n")

def or_op(src, dest):
    g.write("\tmovl %ebp, copy1_ebp\n")
    registers = ["eax", "ebx", "ecx", "edx", "esi", "edi"]
    for reg in registers:
        g.write(f"\tmovl copy_{reg}, %ebp\n")
        g.write(f"\tmovl %ebp, copy1_{reg}\n")
        g.write(f"\tmovl %{reg}, copy_{reg}\n")

    g.write("\tmovl $0, %ecx\n")
    g.write(f"\tmovl {src}, src_op\n")
    # extragem byte-ul 3
    g.write(f"\tmovl src_op, %ebx\n")
    g.write("\tshrl $24, %ebx\n") 
    g.write(f"\tmovl copy_{dest[1:]}, %eax\n")
    g.write("\tshrl $24, %eax\n")
    g.write("\tmovl table_or(,%eax,4), %edi\n")
    g.write("\tmovb (%edi, %ebx, 1), %al\n")

    g.write("\tmovb %al, %cl\n")
    g.write("\tshll $8, %ecx\n")

    # extragem byte-ul 2
    g.write(f"\tmovl src_op, %ebx\n")
    g.write("\tshrl $16, %ebx\n")
    g.write("\tmovzbl %bl, %ebx\n") 
    g.write(f"\tmovl copy_{dest[1:]}, %eax\n")
    g.write("\tshrl $16, %eax\n")
    g.write("\tmovzbl %al, %eax\n")
    g.write("\tmovl table_or(,%eax,4), %edi\n")
    g.write("\tmovb (%edi, %ebx, 1), %al\n")

    g.write("\tmovb %al, %cl\n")
    g.write("\tshll $8, %ecx\n")

   # extragem byte-ul 1
    g.write(f"\tmovl src_op, %ebx\n")
    g.write("\tshrl $8, %ebx\n")
    g.write("\tmovzbl %bl, %ebx\n")
    g.write(f"\tmovl copy_{dest[1:]}, %eax\n")
    g.write("\tshrl $8, %eax\n")
    g.write("\tmovzbl %al, %eax\n")
    g.write("\tmovl table_or(,%eax,4), %edi\n")
    g.write("\tmovb (%edi, %ebx, 1), %al\n")

    g.write("\tmovb %al, %cl\n")
    g.write("\tshll $8, %ecx\n")

    # extragem byte-ul 0
    g.write(f"\tmovl src_op, %ebx\n")
    g.write("\tmovzbl %bl, %ebx\n")
    g.write(f"\tmovl copy_{dest[1:]}, %eax\n")
    g.write("\tmovzbl %al, %eax\n")
    g.write("\tmovl table_or(,%eax,4), %edi\n")
    g.write("\tmovb (%edi, %ebx, 1), %al\n")

    g.write("\tmovb %al, %cl\n") 

    g.write(f"\tmovl %ecx, %{dest[1:]}\n")
    
    # restaurarea registrilor
    for reg in registers:
        if reg != dest[1:]:
            g.write(f"\tmovl copy_{reg}, %{reg}\n")

    for reg in registers:
        g.write(f"\tmovl copy1_{reg}, %ebp\n")
        g.write(f"\tmovl %ebp, copy_{reg}\n")
    g.write("\tmovl copy1_ebp, %ebp\n")

def xor_op(src, dest):
    # salvare registre
    g.write("\tmovl %ebp, copy1_ebp\n")
    registers = ["eax", "ebx", "ecx", "edx", "edi"]
    for reg in registers:
        g.write(f"\tmovl copy_{reg}, %ebp\n")
        g.write(f"\tmovl %ebp, copy1_{reg}\n")
        g.write(f"\tmovl %{reg}, copy_{reg}\n")

    g.write("\tmovl $0, %ecx\n")

    # === extragere biti src ===
    g.write(f"\tmovl {src}, %edx\n")
    for i in range(32):
        g.write("\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")
        g.write("\tshll $31, %eax\n")
        g.write("\tshrl $31, %eax\n")     # eax = bit (0/1)
        g.write(f"\tmovb %al, src+{i}\n")

    # === extragere biti dest ===
    g.write(f"\tmovl copy_{dest[1:]}, %edx\n")
    for i in range(32):
        g.write("\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")
        g.write("\tshll $31, %eax\n")
        g.write("\tshrl $31, %eax\n")     # eax = bit (0/1)
        g.write(f"\tmovb %al, dest+{i}\n")

    # === XOR bit cu bit ===
    for i in range(32):
        g.write(f"\tmovzbl dest+{i}, %eax\n")   # eax = A (0/1)
        g.write(f"\tmovzbl src+{i}, %ebx\n")    # ebx = B (0/1)
        g.write("\tmovl table_xor(,%eax,4), %edi\n")
        g.write("\tmovb (%edi,%ebx,1), %al\n")  # al = A XOR B
        g.write(f"\tmovb %al, dest+{i}\n")

    # === reconstructie rezultat CORECTA ===
    g.write("\tmovl $0, %edx\n")  # edx = 0 inițial

    for i in range(32):
        g.write(f"\tmovzbl dest+{i}, %eax\n")  # eax = bit i

        # folosim tabela OR pentru a seta LSB
        g.write("\tmovl table_or(,%edx,4), %edi\n")  # edi = table_or[edx]
        g.write("\tmovb (%edi,%eax,1), %al\n")      # al = edx | bit_i
        g.write("\tmovb %al, %dl\n")                # setam LSB în edx

        # mutam edx cu 1 bit la stânga pentru urmatorul bit
        if i != 31:
            g.write("\tshll $1, %edx\n")

    g.write(f"\tmovl %edx, {dest}\n")

    # restaurarea registrilor
    for reg in registers:
        if reg != dest[1:]:
            g.write(f"\tmovl copy_{reg}, %{reg}\n")

    for reg in registers:
        g.write(f"\tmovl copy1_{reg}, %ebp\n")
        g.write(f"\tmovl %ebp, copy_{reg}\n")
    g.write("\tmovl copy1_ebp, %ebp\n")

def not_op(dest):
    dest= dest.replace("%", "").strip()
    g.write("\tmovl %eax, copy_eax\n")
    g.write("\tmovl %edx, copy_edx\n")
    
    g.write(f"\tmovl %{dest}, %edx\n")        #se muta valoarea din dest in %edx
    for i in range(32):
        g.write(f"\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")        #pentru fiecare bit i: - se deplaseaza bitul pe pozitia 0 - se izoleaza - se salveaza in dest[i]
        and_op("$1", "%eax")
        g.write(f"\tmovb %al, dest + {i}\n")

    for i in range(32):
        g.write(f"\tmovzbl dest+{i}, %eax\n")
        g.write(f"\tmovb table_not(%eax), %al\n")    #ia fiecare bit(0 sau 1) - il foloseste ca index in table_not 
        g.write(f"\tmovb %al, dest+{i}\n")        #se retine rezultatul bitiilor in dest[i] in functie de pozitia pe care se afla

    g.write("\tmovl $0, %edx\n")
    for i in range(32):
        g.write(f"\tmovzbl dest+{i}, %eax\n")     #reconstruire pe 32 de biti al rezultatului dorit
        g.write(f"\tshll ${i}, %eax\n")
        or_op("%eax", "%edx")
    
    g.write(f"\tmovl %edx, %{dest}\n")     #se muta valoarea din %edx in dest
    
    if dest != "eax":
        g.write("\tmovl copy_eax, %eax\n")        #se restaureaza registrul folosit in aceasta functie doar daca nu coincide dest cu eax/edx
    if dest != "edx":
        g.write("\tmovl copy_edx, %edx\n")

def add(src, dest):
    g.write("\tmovl %ebp, copy_ebp\n")
    registers = ["eax", "ebx", "ecx", "edx", "esi", "edi", "esp"]
    for reg in registers:
        g.write(f"\tmovl copy_{reg}, %ebp\n")
        g.write(f"\tmovl %ebp, copy1_{reg}\n")
        g.write(f"\tmovl %{reg}, copy_{reg}\n")

    # extragem bitii din sursa
    g.write(f"\tmovl {src}, %edx\n")
    for i in range(32):
        g.write(f"\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")
        and_op("$1", "%eax")
        g.write(f"\tmovb %al, src + {i}\n")

    # extragem bitii din destinatie
    g.write(f"\tmovl copy_{dest[1:]}, %edx\n")
    for i in range(32):
        g.write(f"\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")
        and_op("$1", "%eax")
        g.write(f"\tmovb %al, dest + {i}\n")
    
    g.write("\tmovl $0, %ecx\n") # carry initial = 0
    for i in range(32):
        # citire operanzi din buffere
        g.write(f"\tmovzbl dest + {i}, %eax\n") # a
        g.write(f"\tmovzbl src + {i}, %ebx\n")  # b
        g.write("\tmovl %ecx, old_carry\n") # salvam carry vechi

        # a xor b
        g.write("\tmovl table_xor(,%eax,4), %edi\n")
        g.write("\tmovb (%edi, %ebx, 1), %al\n")
        g.write("\tmovzbl %al, %esi\n") # esi = a xor b

        # calcul carry nou
        # 1. a and b
        g.write(f"\tmovzbl dest + {i}, %eax\n")
        g.write(f"\tmovzbl src + {i}, %ebx\n") 
        g.write("\tmovl table_and(,%eax,4), %edi\n")
        g.write("\tmovb (%edi, %ebx, 1), %al\n")
        g.write("\tmovzbl %al, %edx\n") # edx = a and b

        # 2. carry vechi and (a xor b)
        g.write("\tmovl %ecx, copy3_ecx\n")
        g.write("\tmovl old_carry, %ecx\n")
        g.write("\tmovl table_and(,%ecx,4), %edi\n")
        g.write("\tmovb (%edi, %esi, 1), %al\n")
        g.write("\tmovzbl %al, %eax\n")
        g.write("\tmovzbl %al, %eax\n")
        g.write("\tmovl copy3_ecx, %ecx\n")

        # 3. carry final = edx or eax
        g.write("\tmovl table_or(,%edx,4), %edi\n")
        g.write("\tmovb (%edi, %eax, 1), %al\n")
        g.write("\tmovzbl %al, %ecx\n")

        # 4. calcul suma finala
        g.write("\tmovl %ecx, copy3_ecx\n")
        g.write("\tmovl old_carry, %ecx\n")
        g.write("\tmovl table_xor(,%esi,4), %edi\n")
        g.write("\tmovb (%edi, %ecx, 1), %al\n")
        g.write(f"\tmovb %al, dest + {i}\n")
        g.write("\tmovl copy3_ecx, %ecx\n")

    # reconstructia registrului destinatie
    g.write("\tmovl $0, %edx\n")
    for i in range(32):
        g.write(f"\tmovzbl dest + {i}, %eax\n")
        g.write(f"\tshll ${i}, %eax\n")
        or_op("%eax", "%edx")
    g.write(f"\tmovl %edx, {dest}\n")

    # restaurarea registrilor
    for reg in registers:
        if reg != dest[1:]:
            g.write(f"\tmovl copy_{reg}, %{reg}\n")

    for reg in registers:
        g.write(f"\tmovl copy1_{reg}, %ebp\n")
        g.write(f"\tmovl %ebp, copy_{reg}\n")
    g.write("\tmovl copy_ebp, %ebp\n")

def sub(src, dest):
    g.write(f"\tmovl {src}, src_sub\n")
    not_op(src)
    add("$1", src)
    add(src, dest)
    g.write(f"\tmovl src_sub, {src}\n")

def mul(src):
    g.write("\tmovl %ebp, copy2_ebp\n")
    registers = ["eax", "ebx", "ecx", "esi", "edi"]
    for reg in registers:
        g.write(f"\tmovl copy_{reg}, %ebp\n")
        g.write(f"\tmovl %ebp, copy2_{reg}\n")
        g.write(f"\tmovl %{reg}, copy_{reg}\n")

    # initializare:
    # %esi = multiplicand (cel care se shifteaza)
    # %edi = multiplicator (cel care se testeaza bit cu bit)
    # %ecx = acumulator (rezultatul sumei)
    g.write(f"\tmovl {src}, %esi\n")
    g.write("\tmovl copy_eax, %edi\n")
    g.write("\tmovl $0, %ecx\n")

    for i in range(32):
        # 1. extragem bitul i din multiplicator
        g.write("\tmovl %edi, %eax\n")
        if i > 0:
            g.write(f"\tshrl ${i}, %eax\n")
        
        # and_op va folosi copy_ si copy1_, deci copy2_ ramane neatins
        and_op("$1", "%eax") 

        # 2. verificam daca bitul i a fost 1
        g.write("\tcmp $1, %eax\n")
        
        skip_label = f"skip_add_{i}"
        # daca bitul e 0, sarim peste adunare
        j(skip_label, "ne", i + 2000) 

        # 3. pregatim valoarea de adunat: (multiplicand << i)
        g.write("\tmovl %esi, %ebx\n")
        if i > 0:
            g.write(f"\tshll ${i}, %ebx\n")
    
        # add va folosi copy_ si copy1_, protejand variabilele noastre din copy2_
        add("%ebx", "%ecx")
        g.write(f"{skip_label}:\n")

    # punem rezultatul in eax inainte de restaurare
    g.write("\tmovl %ecx, %eax\n")

    for reg in registers:
        if reg != "eax":
            g.write(f"\tmovl copy_{reg}, %{reg}\n")

    for reg in registers:
        g.write(f"\tmovl copy2_{reg}, %ebp\n")
        g.write(f"\tmovl %ebp, copy_{reg}\n")

    g.write("\tmovl copy2_ebp, %ebp\n")

def div(src):
    # folosim copy2 pentru a proteja contextul functiei div
    g.write("\tmovl %ebp, copy2_ebp\n")
    registers = ["eax", "ebx", "ecx", "edx", "esi", "edi"]
    for reg in registers:
        g.write(f"\tmovl copy_{reg}, %ebp\n")
        g.write(f"\tmovl %ebp, copy2_{reg}\n")
        g.write(f"\tmovl %{reg}, copy_{reg}\n")

    # initializare:
    # %esi = deimpartitul (valoarea initiala din eax)
    # %edi = impartitorul (src)
    # %ecx = catul (pleaca de la 0)
    # %edx = restul partial (pleaca de la 0)
    g.write(f"\tmovl copy_eax, %esi\n")
    g.write(f"\tmovl {src}, %edi\n")
    g.write("\tmovl $0, %ecx\n")
    g.write("\tmovl $0, %edx\n")

    # algoritmul de impartire bit cu bit
    for i in range(31, -1, -1):
        # 1. shiftam restul la stanga cu 1 bit
        g.write("\tshll $1, %edx\n")
        
        # 2. aducem bitul i din deimpartit (%esi) in LSB-ul restului (%edx)
        g.write("\tmovl %esi, %eax\n")
        if i > 0:
            g.write(f"\tshrl ${i}, %eax\n")
        
        # izolam bitul i si il punem in restul partial folosind or
        and_op("$1", "%eax") 
        or_op("%eax", "%edx")

        # 3. verificam daca restul >= impartitor (%edx >= %edi)
        g.write("\tcmp %edi, %edx\n")
        
        skip_label = f"skip_div_{i}"
        # daca restul < impartitor, sarim peste scadere
        j(skip_label, "b", i + 3000)

        # 4. daca restul >= impartitor:
        sub("%edi", "%edx") # scadem impartitorul din rest
        
        # setam bitul i in cat (%ecx)
        g.write("\tmovl $1, %eax\n")
        if i > 0:
            g.write(f"\tshll ${i}, %eax\n")
        or_op("%eax", "%ecx")

        g.write(f"{skip_label}:\n")

    g.write("\tmovl %ecx, %eax\n")

    # restaurarea registrilor
    for reg in registers:
        if reg != "eax" and reg != "edx":
            g.write(f"\tmovl copy_{reg}, %{reg}\n")

    for reg in registers:
        g.write(f"\tmovl copy2_{reg}, %ebp\n")
        g.write(f"\tmovl %ebp, copy_{reg}\n")

    g.write("\tmovl copy2_ebp, %ebp\n")

def pop(dest):
    g.write(f"\tmovl 0(%esp), {dest}\n")
    add("$4", "%esp")
    
def push(dest):
    add("$-4", "%esp")
    g.write(f"\tmovl {dest}, 0(%esp)\n")

def inc(dest):
    add("$1", dest)
    
def dec(dest):
    add("$-1", dest)

def loop(src, loop_counter):
    dec("%ecx\n")

    #mutam adresa sursa si adresa de exit
    g.write(f"\tmovl %eax, copy_eax\n")
    g.write(f"\tmovl %ebx, copy_ebx\n")
    g.write(f"\tmovl ${src}, %eax\n")
    g.write(f"\tmovl $labell{loop_counter}, %ebx\n")
    
    g.write("\tcmp $0, %ecx\n") #verificam cand se termina comanda loop din asm
    g.write("\tcmovne %eax, %ebx\n")
    push("%ebx")
    
    g.write(f"\tmovl copy_eax, %eax\n")
    g.write(f"\tmovl copy_ebx, %ebx\n")
    #restauram registrii
    
    g.write("\tret\n")
    g.write(f"labell{loop_counter}:\n")

def jmp(src): #punem in eax adresa src, dupa o plasam pe stiva si facem jmp folosind ret
    g.write(f"\tmovl %eax, copy_eax\n")
    g.write(f"\tmovl ${src}, %eax\n")
    push("%eax")
    
    g.write(f"\tmovl copy_eax, %eax\n")
    g.write(f"\tret\n")

def j(src, suf, j_counter): #suf = sufixul jmpului conditionat/j_counter=nr de jmpuri conditionate pentru a nu sari la aceasi adresa de memorie in cazul in care exista mai multe
    #copiem registri
    g.write(f"\tmovl %eax, copy_eax\n")
    g.write(f"\tmovl %ebx, copy_ebx\n")
    g.write(f"\tmovl ${src}, %eax\n") #eax are adresa src
    g.write(f"\tmovl $labelj{j_counter}, %ebx\n") #ebx are adresa fix de dupa jmp daca acesta nu indeplineste conditia de jmp
    
    g.write(f"\tcmov{suf} %eax, %ebx\n") #se va muta adresa src (eax) in ebx doar daca conditia de jmp este indeplinita
    
    push("%ebx")
    
    g.write(f"\tmovl copy_eax, %eax\n")
    g.write(f"\tmovl copy_ebx, %ebx\n") #restauram registrii
    g.write(f"\tret\n")
    g.write(f"labelj{j_counter}:\n")

def lea(src, dest):
    src=src.replace(" ", "")
    if '(' in src:
        offset = src.split('(')[0].strip()
        src = src.split('(')[1].replace(')', '').strip()
        
        if "%" not in src: 
            src = f"%{src}"
            
        g.write(f"\tmovl {src}, {dest}\n") #dest = src
        
        if offset!='0' and offset:
            add(f"${offset}", dest)
    else:
        g.write(f"\tmovl ${src}, {dest}\n")
