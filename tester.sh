#!/bin/bash

INPUT_DIR="inputs"
OUTPUT_DIR="outputs"
BUILD_DIR="build"
GENERATOR="main.py"

mkdir -p "$OUTPUT_DIR"
mkdir -p "$BUILD_DIR"

echo -e "TEST         | GEN | GCC | REZULTAT [STDOUT]"
echo "------------------------------------------------------------"

for input_path in $(ls $INPUT_DIR/input*.s | sort -V); do
    test_file=$(basename "$input_path")
    idx=$(echo "$test_file" | grep -o '[0-9]\+')
    output_path="$OUTPUT_DIR/output$idx.s"
    
    bin_in="$BUILD_DIR/bin_in_$idx"
    bin_out="$BUILD_DIR/bin_out_$idx"

    python3 "$GENERATOR" "$input_path" "$output_path" > /dev/null 2>&1
    if [ $? -eq 0 ]; then GEN_ICON="✅"; else GEN_ICON="❌"; fi

    gcc -m32 "$input_path" -o "$bin_in" -Wl,-z,noexecstack -no-pie > /dev/null 2>&1
    RES_IN=$?
    
    gcc -m32 "$output_path" -o "$bin_out" -Wl,-z,noexecstack -no-pie > /dev/null 2>&1
    RES_OUT=$?

    if [ $RES_IN -eq 0 ] && [ $RES_OUT -eq 0 ]; then
        GCC_ICON="✅"
        
        OUT_EXPECTED=$("$bin_in" | tr -d '\0')
        OUT_ACTUAL=$("$bin_out" | tr -d '\0')

        if [ "$OUT_EXPECTED" == "$OUT_ACTUAL" ]; then
            RESULT="✅ MATCH: [$OUT_ACTUAL]"
        else
            RESULT="❌ DIFF! Exp: [$OUT_EXPECTED] | Got: [$OUT_ACTUAL]"
        fi
    else
        GCC_ICON="❌"
        RESULT="⏭️ Compilare eșuată (Verifică sintaxa ASM)"
    fi

    printf "%-12s | %s  | %s  | %s\n" "$test_file" "$GEN_ICON" "$GCC_ICON" "$RESULT"
done

rm -rf "$BUILD_DIR"
