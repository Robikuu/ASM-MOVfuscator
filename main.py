import functions
import sys

if len(sys.argv) != 3:
    print("Programul de ruleaza folosind ./main.py [INPUT_FILE] [OUTPUT_FILE]")
    sys.exit(1)

inputf = sys.argv[1]
outpuf = sys.argv[2]

fin = open(inputf, "r")
functions.init(outpuf)

loop_counter=0
j_counter=0
for line in fin:
    if line.startswith(".text"):
        functions.complete_data()
    elif "add" in line:
        src, dest = line.split("#")[0].strip(" addl").split(",")
        functions.add(src.strip(), dest.strip())
    elif "xorl" in line:
        line=line.split("#")[0].strip()
        info=line.replace("xorl", "", 1).strip()
        src, dest=[x.strip() for x in info.split(",")]
        functions.operatori_logici(src.strip(), dest.strip(), "table_xor")
    elif "andl" in line:
        info=line.replace("andl", "", 1)
        src, dest=[x.strip() for x in info.split(",")]
        functions.operatori_logici(src.strip(), dest.strip(), "table_and")
    elif "orl" in line:
        info=line.replace("orl", "", 1)
        src, dest=[x.strip() for x in info.split(",")]
        functions.operatori_logici(src.strip(), dest.strip(), "table_or")
    elif "notl" in line:
        dest = line.split("#")[0].strip().replace("notl", "")
        functions.not_operator(dest.strip())
    elif "lea" in line:
        info=line.split("#")[0].strip().replace("lea", "")
        base, dest = [x.strip() for x in info.split(',')]
        functions.lea_operator(base,dest)
    elif "jmp" in line or line.strip().startswith("j"):
        line = line.split("#")[0].strip().split(" ")
        if line[0] == "jmp":
            functions.jmp(line[1])
        else:
            suf = line[0][1:]
            functions.j(line[1],suf,j_counter)
            j_counter += 1
    elif "loop" in line:
        line = line.split("#")[0].strip().split(" ")
        functions.loop(line[1])
    else:
        functions.g.write(line)

fin.close()
functions.close()
