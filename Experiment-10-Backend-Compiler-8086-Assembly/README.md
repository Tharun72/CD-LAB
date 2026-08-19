# Experiment 10 — Back-End of a Compiler: TAC to 8086 Assembly

## Aim
Implement the back-end of a compiler for which three-address code is
given as input and 8086 assembly language code is produced as output.

## Tools
- gcc (plain C, no LEX/YACC required for this experiment)

## Folder Structure
```
Experiment-10-Backend-Compiler-8086-Assembly/
├── source/backend_codegen.c
├── input_output/
│   ├── input_tac.txt     (6 TAC statements)
│   └── exp10_output.txt  (generated 8086 assembly program)
├── screenshots/
└── README.md
```

## How to Build & Run
```bash
cd source
gcc backend_codegen.c -o backend_codegen
./backend_codegen ../input_output/input_tac.txt
```

## Description
For each TAC statement of the form `x = y op z` or `x = y`, the
generator emits standard 8086 instructions:
- `x = y + z`  →  `MOV AX,y` / `MOV BX,z` / `ADD AX,BX` / `MOV x,AX`
- `x = y - z`  →  ... `SUB AX,BX` ...
- `x = y * z`  →  ... `MUL BX` ...
- `x = y / z`  →  ... `XOR DX,DX` / `DIV BX` ...
- `x = y`      →  `MOV AX,y` / `MOV x,AX`

The output is wrapped in a complete `.MODEL SMALL` / `.CODE` / `MAIN
PROC ... MAIN ENDP` assembly program skeleton with a DOS program-exit
sequence (`MOV AH,4CH` / `INT 21H`), ready to assemble with an 8086
assembler such as MASM/TASM/emu8086.

## Result
Successfully translated a 6-statement three-address-code sequence
(including a chained expression `a = (b + c) * d` and a division
`result = (x - y) / z`) into correct, complete 8086 assembly code.
