# Experiment 9 — Simple Code Optimization Techniques

## Aim
Implement simple code optimization techniques — Constant Folding,
Strength Reduction, and Algebraic Transformation — on three-address
code statements.

## Tools
- gcc (plain C, no LEX/YACC required for this experiment)

## Folder Structure
```
Experiment-09-Code-Optimization-Techniques/
├── source/code_optimizer.c
├── input_output/
│   ├── input_tac_code.txt   (10 TAC statements used as input)
│   └── exp9_output.txt      (original vs optimized side by side)
├── screenshots/
└── README.md
```

## How to Build & Run
```bash
cd source
gcc code_optimizer.c -o code_optimizer
./code_optimizer
```

## Optimizations Implemented
1. **Constant Folding** — `t1 = 4 + 2;` → `t1 = 6;`
2. **Algebraic Transformation** — `x + 0 -> x`, `x * 1 -> x`,
   `x * 0 -> 0`, `x - 0 -> x`
3. **Strength Reduction** — `x * 2 -> x + x`; multiplication/division
   by a power of 2 is converted to a bit-shift, e.g. `y * 8 -> y << 3`,
   `z / 4 -> z >> 2`

Each input line is parsed with `sscanf`, checked against the
optimization rules in priority order (constant folding → algebraic →
strength reduction), and left unchanged if no rule applies.

## Result
Successfully optimized 9 out of 10 sample TAC statements, correctly
applying constant folding, algebraic simplification, and strength
reduction, while leaving the one statement with no applicable
optimization (`t10 = e + f;`) unchanged.
