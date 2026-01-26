g = None

def init(filename):
    global g
    g = open(filename, "w")

def close():
    global g
    if g:
        g.close()
        
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
    
def push(dest):
    add("$-4", "%esp")
    g.write(f"\tmovl {dest}, 0(%esp)")
    
def sub(src, dest):
    not_operator(src)
    add("$1",src)
    add(src,dest)
    
def inc(src):
    add("$1",src)
    
def dec(src):
    add("$-1",src)
    
#JMPS SI LOOPS
def loop(src,loop_counter):
    dec("%ecx")

    #mutam adresa sursa si adresa de exit
    g.write(f"\tmovl %eax, copy_eax")
    g.write(f"\tmovl %ebx, copy_ebx")
    g.write(f"\tmovl ${src}, %eax")
    g.write(f"\tmovl $labell{loop_counter}, %ebx")
    
    g.write("\tcmp $0, %ecx") #verificam cand se termina comanda loop din asm
    g.write("\tcmovne %eax, %ebx")
    push("%ebx")
    
    g.write(f"\tmovl copy_eax, %eax")
    g.write(f"\tmovl copy_ebx, %ebx")
    #restauram registrii
    
    g.write("\tret")
    g.write(f"labell{loop_counter}:")
    
def jmp(src): #punem in eax adresa src, dupa o plasam pe stiva si facem jmp folosind ret
    g.write(f"\tmovl %eax, copy_eax")
    g.write(f"\tmovl ${src}, %eax")
    push("%eax")
    
    g.write(f"\tmovl copy_eax, %eax")
    g.write(f"\tret")

def j(src,suf,j_counter): #suf=sufixul jmpului conditionat/j_counter=nr de jmpuri conditionate pentru a nu sari la aceasi adresa de memorie in cazul in care exista mai multe
    #copiem registri
    g.write(f"\tmovl %eax, copy_eax")
    g.write(f"\tmovl %ebx, copy_ebx")
    g.write(f"\tmovl ${src}, %eax") #eax are adresa src
    g.write(f"\tmovl $labelj{j_counter}, %ebx") #ebx are adresa fix de dupa jmp daca acesta nu indeplineste conditia de jmp
    
    g.write(f"\tcmov{suf} %eax, %ebx") #se va muta adresa src (eax) in ebx doar daca conditia de jmp este indeplinita
    
    push("%ebx")
    
    g.write(f"\tmovl copy_eax, %eax")
    g.write(f"\tmovl copy_ebx, %ebx") #restauram registri
    g.write(f"\tret")
    g.write(f"labelj{j_counter}:")
    

def operatori_logici(src, dest, table_name):
    dest= dest.replace("%", "").strip()
    
    registers = ["eax","ebx", "edx", "edi"]
    for r in registers:                       #salvează valorile registrilor eax, ebx, edx, edi în variabile temporare precum copy_eax, copy_ebx etc.
        g.write(f"\tmovl %{r}, copy_{r}\n")
        
    g.write(f"\tmovl {src}, %edx\n")    #ia valoarea din src si o muta in %edx
    for i in range(32):
        g.write("\tmovl %edx, %eax\n") 
        g.write(f"\tshrl ${i}, %eax\n")        #pentru fiecare bit i: - se deplaseaza bitul pe pozitia 0 - se izoleaza - se salveaza in src[i]
        g.write("\tandl $1, %eax\n")
        g.write(f"\tmovb %al, src+{i}\n")
    
    g.write(f"\tmovl copy_{dest}, %edx\n")    #ia valoarea din dest si o muta in %edx
    for i in range(32):
        g.write("\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")        #pentru fiecare bit i: - se deplaseaza bitul pe pozitia 0 - se izoleaza - se salveaza in dest[i]
        g.write("\tandl $1, %eax\n")
        g.write(f"\tmovb %al, dest+{i}\n")

    for i in range(32):
        g.write(f"\tmovzbl dest+{i}, %eax\n")       # %eax=bitul de pe pozitia i din dest
        g.write(f"\tmovzbl src+{i}, %ebx\n")        # %ebx=bitul de pe pozitia i din src
        g.write(f"\tmovl {table_name}(,%eax,4), %edi\n")    # edi= table_name[%eax][%ebx] (table_name = lookup table pentru and, or, xor)
        g.write("\tmovb (%edi,%ebx,1), %al\n")
        g.write(f"\tmovb %al, dest+{i}\n")    #rezultatul se stocheaza in dest[i]
    
    g.write("\tmovl $0, %edx\n")    
    for i in range(32):                            #reconstruire pe 32 de biti al rezultatului dorit
        g.write(f"\tmovzbl dest+{i}, %eax\n")
        g.write(f"\tshll ${i}, %eax\n")
        g.write("\torl %eax, %edx\n")            #se stocheaza in %edx pe rand bitii, fiecare pe pozitia lui
        
    g.write(f"\tmovl %edx, %{dest}\n")        #se muta valoarea din %edx in dest

    #se restaureaza registrii folositi in aceasta functie
    for r in registers:
        if dest!=r:
            g.write(f"\tmovl copy_{r}, %{r}\n")


def not_operator(dest):
    dest= dest.replace("%", "").strip()
    g.write("\tmovl %eax, copy_eax\n")        #se salveaza registrii eax, edx in variabile temporale copy_eax, respectiv, copy_edx
    g.write("\tmovl %edx, copy_edx\n")
    
    g.write(f"\tmovl %{dest}, %edx\n")        #se muta valoarea din dest in %edx
    for i in range(32):
        g.write(f"\tmovl %edx, %eax\n")
        g.write(f"\tshrl ${i}, %eax\n")        #pentru fiecare bit i: - se deplaseaza bitul pe pozitia 0 - se izoleaza - se salveaza in dest[i]
        g.write(f"\tandl $1, %eax\n")
        g.write(f"\tmovb %al, dest + {i}\n")

    for i in range(32):
        g.write(f"\tmovzbl dest+{i}, %eax\n")
        g.write(f"\tmovb table_not(%eax), %al\n")    #ia fiecare bit(0 sau 1) - il foloseste ca index in table_not 
        g.write(f"\tmovb %al, dest+{i}\n")        #se retine rezultatul bitiilor in dest[i] in functie de pozitia pe care se afla
    
    g.write("\tmovl $0, %edx\n")
    for i in range(32):
        g.write(f"\tmovzbl dest+{i}, %eax\n")     #reconstruire pe 32 de biti al rezultatului dorit
        g.write(f"\tshll ${i}, %eax\n")
        g.write("\torl %eax, %edx\n")
    
    g.write(f"\tmovl %edx, %{dest}\n")     #se muta valoarea din %edx in dest
    
    if dest != "eax":
        g.write("\tmovl copy_eax, %eax\n")        #se restaureaza registrul folosit in aceasta functie doar daca nu coincide dest cu eax/edx
    if dest != "edx":
        g.write("\tmovl copy_edx, %edx\n")

def lea_operator(base,dest):      #calculează o adresă efectivă de forma offset(base) și o pune în dest
    base=base.replace(" ", "")
    if '(' in base:  # verificare forma offset(base)
        offset = base.split('(')[0].strip()                    #separarea offsetului de registru
        base = base.split('(')[1].replace(')', '').strip()
        
        if "%" not in base: 
            base = f"%{base}"
            
        g.write(f"\tmovl {base}, {dest}\n")    #dest = base
        
        if offset!='0' and offset:
            add(f"${offset}", dest)    #dest = base + offset
    else:
        g.write(f"\tmovl ${base}, {dest}\n")    #pentru instructiuni de forma lea v, %edi (lea dest, base)
                                                #devine dest=base


