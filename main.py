import functions
import sys
import re

if len(sys.argv) != 3:
    print("Programul se ruleaza folosind ./main.py [INPUT_FILE] [OUTPUT_FILE]")
    sys.exit(1)

input = sys.argv[1]
output = sys.argv[2]

fin = open(input, "r")
functions.init(output)

loop_counter=0
j_counter=0
for line in fin:
    line = line.strip()
    if line.startswith("#") or line.startswith(";"):
        functions.g.write(f"\t{line}\n")
    elif line.startswith(".text"):
        functions.complete_data()
    elif ":" in line and re.split("[#;]", line)[0].strip()[-1] == ":":
        functions.g.write(f"\t{line}\n")
    elif line.startswith("add"):
        src, dest = re.sub(r"^addl?\s+", "", re.split("[#;]", line)[0]).split(",")
        functions.add(src.strip(), dest.strip())
    elif line.startswith("sub"):
        src, dest = re.sub(r"^subl?\s+", "", re.split("[#;]", line)[0]).split(",")
        functions.sub(src.strip(), dest.strip())
    elif line.startswith("mul"):
        src = re.sub(r"^mull?\s+", "", re.split(r"[#;]", line)[0]).strip()
        functions.mul(src)
    elif line.startswith("div"):
        src = re.sub(r"^divl?\s+", "", re.split(r"[#;]", line)[0]).strip()
        functions.div(src)
    elif line.startswith("xor"):
        src, dest = re.sub(r"^xorl?\s+", "", re.split("[#;]", line)[0]).split(",")
        functions.xor_op(src.strip(), dest.strip())
    elif line.startswith("and"):
        src, dest = re.sub(r"^andl?\s+", "", re.split("[#;]", line)[0]).split(",")
        functions.and_op(src.strip(), dest.strip())
    elif line.startswith("or"):
        src, dest = re.sub(r"^orl?\s+", "", re.split("[#;]", line)[0]).split(",")
        functions.or_op(src.strip(), dest.strip())
    elif line.startswith("not"):
        dest = re.sub(r"^notl?\s+", "", re.split("[#;]", line)[0]).strip()
        functions.not_op(dest.strip())
    elif line.startswith("push"):
        dest = re.sub(r"^pushl?\s+", "", re.split("[#;]", line)[0]).strip()
        functions.push(dest.strip())
    elif line.startswith("pop"):
        dest = re.sub(r"^popl?\s+", "", re.split("[#;]", line)[0]).strip()
        functions.pop(dest.strip())
    elif line.startswith("lea"):
        src, dest = re.sub(r"^lea\s+", "", re.split("[#;]", line)[0]).split(",")
        functions.lea(src.strip(), dest.strip())
    elif line.strip().startswith("j"):
        line = re.split("[#;]", line)[0].strip().split()
        if line[0].strip() == "jmp":
            functions.jmp(line[1])
        else:
            suf = line[0][1:]
            functions.j(line[1],suf,j_counter)
            j_counter += 1
    elif "loop" in line:
        line = re.split("[#;]", line)[0].strip().split()
        functions.loop(line[1],loop_counter)
        loop_counter += 1
    else:
        functions.g.write(f"\t{line}\n")

fin.close()
functions.close()
