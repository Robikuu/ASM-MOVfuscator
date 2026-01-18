import sys

# === CONFIGURARE ===
# Definim tabelele de adevăr pentru operațiile logice
LOGIC_GATES = {
    'xor': [[0, 1], [1, 0]],
    'and': [[0, 0], [0, 1]],
    'or':  [[0, 1], [1, 1]]
}

def write_header(f):
    f.write(".section .data\n")
    
    # 1. Variabile de lucru
    f.write("carry: .byte 0\n")  # Carry-ul curent
    f.write("temp_a: .byte 0\n") 
    f.write("temp_b: .byte 0\n")
    f.write("temp_xor: .byte 0\n")
    f.write("temp_and1: .byte 0\n")
    f.write("temp_and2: .byte 0\n")
    
    # Input dummy pentru testare (poți schimba valorile)
    # 12 + 5 = 17
    f.write("input_x: .long 12\n") 
    f.write("input_y: .long 5\n")
    f.write("result: .long 0\n")

    # Array-uri 'exploded' - stocăm fiecare bit pe un byte separat (0 sau 1)
    f.write("bits_x: .zero 32\n") 
    f.write("bits_y: .zero 32\n")
    f.write("bits_res: .zero 32\n")

    # 2. LOOKUP TABLES PENTRU LOGICĂ
    # Structura: Avem nevoie de tabele 'imbricate' pentru a simula 2 input-uri.
    # Ex: XOR_ROW_0 conține rezultatele pentru 0 XOR B. XOR_ROW_1 pentru 1 XOR B.
    # XOR_MAIN conține pointeri către XOR_ROW_0 și XOR_ROW_1.
    
    for op_name, table in LOGIC_GATES.items():
        # Definim rândurile (rezultatele finale)
        f.write(f"{op_name}_row_0: .byte {table[0][0]}, {table[0][1]}\n")
        f.write(f"{op_name}_row_1: .byte {table[1][0]}, {table[1][1]}\n")
        
        # Definim tabelul principal de pointeri (Base Pointer Table)
        f.write(f"{op_name}_base: .long {op_name}_row_0, {op_name}_row_1\n")

    # 3. LOOKUP TABLE PENTRU EXTRAGEREA BIȚILOR (Byte to Bits)
    # Mapează un byte (0-255) la 8 bytes reprezentând biții săi
    f.write("byte_split_table:\n")
    for i in range(256):
        # Generăm 8 bytes (LSB first pentru x86 e mai natural, dar aici scriem explicit)
        bits = [(i >> b) & 1 for b in range(8)]
        f.write(f"  .byte {', '.join(map(str, bits))}\n")

    f.write("\n.section .text\n")
    f.write(".global _start\n")
    f.write("_start:\n")

# Funcție helper pentru a emite logica MOV pentru OP(src1, src2) -> dest
def emit_logic_op(f, op_name, src1_addr, src2_addr, dest_addr):
    f.write(f"    # {op_name.upper()} ({src1_addr}, {src2_addr}) -> {dest_addr}\n")
    
    # 1. Încărcăm primul operand (0 sau 1)
    f.write(f"    movL {src1_addr}, %eax\n") # movL (32bit) sau movzbl pentru siguranță
    f.write(f"    and $1, %eax\n")           # Sanity check (opțional dacă suntem siguri pe date)
    
    # 2. Folosim primul operand pentru a găsi adresa rândului corect
    # _base + eax * 4 (pentru că sunt pointeri de 32 bit)
    f.write(f"    movL {op_name}_base(,%eax,4), %ebx\n")
    
    # 3. Încărcăm al doilea operand
    f.write(f"    movL {src2_addr}, %ecx\n")
    f.write(f"    and $1, %ecx\n")
    
    # 4. Luăm rezultatul din rândul selectat, la offset-ul dat de al doilea operand
    f.write(f"    movb (%ebx, %ecx, 1), %al\n")
    
    # 5. Salvăm rezultatul
    f.write(f"    movb %al, {dest_addr}\n")

def emit_unpack_bits(f):
    f.write("\n    # --- UNPACKING INPUTS (Explode) ---\n")
    # Pentru simplificare, vom despacheta byte cu byte.
    # Un int are 4 bytes.
    for i in range(4): # 4 bytes in a 32-bit int
        # -- Procesăm Input X --
        f.write(f"    movb input_x+{i}, %al\n")
        f.write(f"    movzbl %al, %eax\n")
        # Calculăm offset-ul în tabela de split: eax * 8
        f.write(f"    lea byte_split_table(,%eax,8), %ebx\n") # ebx = adresa de start a biților
        
        # Copiem cei 8 biți în array-ul bits_x
        for b in range(8):
            f.write(f"    movb {b}(%ebx), %al\n")
            f.write(f"    movb %al, bits_x+{i*8 + b}\n")

        # -- Procesăm Input Y --
        f.write(f"    movb input_y+{i}, %al\n")
        f.write(f"    movzbl %al, %eax\n")
        f.write(f"    lea byte_split_table(,%eax,8), %ebx\n")
        for b in range(8):
            f.write(f"    movb {b}(%ebx), %al\n")
            f.write(f"    movb %al, bits_y+{i*8 + b}\n")

def emit_pack_result(f):
    f.write("\n    # --- PACKING RESULT (Implode) ---\n")
    # Reconstruim result din bits_res. 
    # Aici folosim puțină aritmetică (SHL/OR) doar pentru finalizare,
    # DAR într-un full movfuscator pur, am avea un tabel invers (bits -> byte).
    # Pentru proiectul tău, cred că e acceptabil să folosești logică standard 
    # la final pentru a pune rezultatul în format lizibil, SAU faci tabel invers.
    
    # Voi face varianta cu logică standard DOAR pentru afișare/reconstituire,
    # ca să nu complic codul generatorului excesiv.
    
    f.write("    xor %eax, %eax\n")
    f.write("    xor %ecx, %ecx\n") # contor bit
    
    # Loop unrolled pentru reconstrucție (nu avem loop instruction)
    for i in range(32):
        f.write(f"    movb bits_res+{i}, %bl\n")
        f.write(f"    and $1, %ebx\n")
        # Shiftam bitul la pozitia corecta si il adaugam (OR)
        # Nota: Fara shift variable, e greu doar cu MOV.
        # Putem folosi un tabel 'bit_value_at_pos_N' : [0, 2^N]
        # Dar hai sa folosim shift standard doar aici pentru claritate.
        f.write(f"    shll ${i}, %ebx\n") 
        f.write(f"    or %ebx, result\n")

def generate_full_adder():
    with open("mov_adder.s", "w") as f:
        write_header(f)
        
        emit_unpack_bits(f)
        
        f.write("\n    # --- START FULL ADDER CALCULATION ---\n")
        # Inițializăm carry cu 0
        f.write("    movb $0, carry\n")
        
        # Loopăm prin cei 32 de biți (Unrolled Loop în Assembly)
        for i in range(32):
            f.write(f"\n    # --- BIT {i} ---\n")
            
            # Adresele biților curenți
            addr_a = f"bits_x+{i}"
            addr_b = f"bits_y+{i}"
            addr_res = f"bits_res+{i}"
            
            # 1. SUM = A XOR B XOR Cin
            # T1 = A XOR B
            emit_logic_op(f, 'xor', addr_a, addr_b, "temp_xor")
            # Sum = T1 XOR Carry
            emit_logic_op(f, 'xor', "temp_xor", "carry", addr_res)
            
            # 2. CARRY OUT = (A AND B) OR (Cin AND (A XOR B))
            # T2 = A AND B
            emit_logic_op(f, 'and', addr_a, addr_b, "temp_and1")
            # T3 = Carry AND T1 (unde T1 e A XOR B, deja calculat in temp_xor)
            emit_logic_op(f, 'and', "carry", "temp_xor", "temp_and2")
            # Cout = T2 OR T3
            emit_logic_op(f, 'or', "temp_and1", "temp_and2", "carry")
            
        emit_pack_result(f)
        
        # Exit syscall (Linux x86)
        f.write("\n    # Exit\n")
        f.write("    mov $1, %eax\n")
        f.write("    mov $0, %ebx\n")
        f.write("    int $0x80\n")

if __name__ == "__main__":
    generate_full_adder()
    print("Fisierul 'mov_adder.s' a fost generat.")
