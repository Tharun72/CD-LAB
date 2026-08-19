# Experiment 8 — Implement Type Checking Using LEX and YACC

## Aim
Implement type checking using LEX and YACC — detecting type mismatches
in assignments and usage of undeclared variables.

## Tools
- flex, bison, gcc

## Folder Structure
```
Experiment-08-Type-Checking-LEX-YACC/
├── source/
│   ├── typecheck.l   (lexer)
│   └── typecheck.y   (grammar + symbol table + type-checking actions)
├── input_output/
│   ├── test_input.txt   (declarations + assignments, some invalid)
│   └── exp8_output.txt  (type-check results)
├── screenshots/
└── README.md
```

## How to Build & Run
```bash
cd source
bison -d typecheck.y
flex typecheck.l
gcc typecheck.tab.c lex.yy.c -o typecheck -lfl
./typecheck ../input_output/test_input.txt
```

## Description
The grammar supports `int`/`float` declarations and assignment
statements. A symbol table records each variable's declared type.
For every assignment, the type of the right-hand-side expression is
inferred (int op int -> int; if either operand is float -> float) and
checked against the left-hand-side variable's declared type. The
checker reports:
- **Type Error** when assigning a `float` expression to an `int`
  variable
- **Error** when a variable is used or assigned without being declared
- **OK** for valid, type-consistent assignments

## Result
Successfully detected a float-to-int type mismatch (`a = b;` where `a`
is int and `b` is float) and an undeclared-variable usage (`d = 5;`),
while correctly accepting all valid assignments.
