# Experiment 7 — Generate Three Address Code Using LEX and YACC

## Aim
Generate three-address code (TAC) for a simple program using LEX and
YACC.

## Tools
- flex, bison, gcc

## Folder Structure
```
Experiment-07-Three-Address-Code-LEX-YACC/
├── source/
│   ├── tac.l    (lexer)
│   └── tac.y    (grammar + TAC-emitting semantic actions)
├── input_output/
│   ├── test_input.txt   (3 assignment statements)
│   └── exp7_output.txt  (generated three-address code)
├── screenshots/
└── README.md
```

## How to Build & Run
```bash
cd source
bison -d tac.y
flex tac.l
gcc tac.tab.c lex.yy.c -o tac_gen -lfl
./tac_gen ../input_output/test_input.txt
```

## Description
For each assignment statement (supporting `+`, `-`, `*`, `/`, and
parentheses), the YACC grammar generates a new temporary variable
(`t1`, `t2`, ...) for every sub-expression, respecting operator
precedence, and emits the corresponding three-address code lines.

Example: `x = (a + b) * (c - d);` generates:
```
t3 = a + b
t4 = c - d
t5 = t3 * t4
x = t5
```

## Result
Successfully generated correct, precedence-respecting three-address
code for all three test assignment statements.
