def add(line):
    output=[]
    parts=line.strip().split()
    reg1=parts[2]
    reg2=parts[1]
    reg2=reg2.replace(",","")
    
    eticheta_reg1=reg1.replace("%", "")+"_val"
    eticheta_reg2=reg2.replace("%", "")+"_val"
     
    output.append(f"    movl {reg1}, {eticheta_reg1}")
    output.append(f"    movl {reg2}, {eticheta_reg2}")

    
    output.append("    movl %eax, input_x")
    output.append("    movl %eax, input_y")

    for i in range(4):
        for var in ["x", "y"]:
            output.append(f"    movb input_{var}+{i}, %al")
            output.append("    movzbl %al, %eax")
            output.append("    lea byte_split_table(%eax,8), %ebx")
            for b in range(8):
                output.append(f"    movb {b}(%ebx), %al")
                output.append(f"    movb %al, bits_{var}+{i*8 + b}")
  
    output.append("    movb $0, carry")
    
    for i in range(32):
        output.append(f"    movl bits_x+{i}, %eax")
        output.append("    andl $1, %eax")
        output.append("    movl xor_base(,%eax,4), %ebx")
        output.append("    movl bits_y+{i}, %ecx")
        output.append("    andl $1, %ecx")
        output.append("    movb (%ebx, %ecx, 1), %al")
        output.append("    movb %al, temp_xor")

        output.append("    movl temp_xor, %eax")
        output.append("    andl $1, %eax")
        output.append("    movl xor_base(,%eax,4), %ebx")
        output.append("    movl carry, %ecx")
        output.append("    andl $1, %ecx")
        output.append("    movb (%ebx, %ecx, 1), %al")
        output.append(f"    movb %al, bits_res+{i}")

        output.append("    movl bits_x+{i}, %eax")
        output.append("    andl $1, %eax")
        output.append("    movl and_base(,%eax,4), %ebx")
        output.append("    movl bits_y+{i}, %ecx")
        output.append("    andl $1, %ecx")
        output.append("    movb (%ebx, %ecx, 1), %al")
        output.append("    movb %al, temp_and1")
        
        output.append("    movl carry, %eax")
        output.append("    andl $1, %eax")
        output.append("    movl and_base(,%eax,4), %ebx")
        output.append("    movl temp_xor, %ecx")
        output.append("    andl $1, %ecx")
        output.append("    movb (%ebx, %ecx, 1), %al")
        output.append("    movb %al, temp_and2")

    
        output.append("    movl temp_and1, %eax")
        output.append("    andl $1, %eax")
        output.append("    movl or_base(,%eax,4), %ebx")
        output.append("    movl temp_and2, %ecx")
        output.append("    andl $1, %ecx")
        output.append("    movb (%ebx, %ecx, 1), %al")
        output.append("    movb %al, carry")

    output.append("    movl $0, result")
    for i in range(32):
        output.append(f"    movl bits_res+{i}, %eax")
        output.append("    andl $1, %eax")
        if i > 0:
            output.append(f"    shll ${i}, %eax")
        output.append("    orl %eax, result")

    output.append("    movl result, %eax")
    output.append(f"    movl %eax, {eticheta_reg1}") 
    output.append(f"    movl {eticheta_reg1}, {reg1}") 

    return output
    
    
add("add %eax, %ebx")    
#%%    
def push(line):
    output=[]
    parts=line.strip().split()
    reg=parts[1] 
    esp=sub("sub $4, %esp")
    output.append(esp)
    output.append(f"    movl {reg}, (%esp)")
    
    return output

#%%
def pop(line):
    output=[]
    parts=line.strip().split()
    reg=parts[1] 
    esp=add("add $4, %esp")
    output.append(esp)
    output.append(f"    movl {reg}, (%esp)")
    
    return output

pop("pop %ebx")    
  
    