# Experiment 6 — Implementation of a Calculator Using LEX and YACC

## Aim
Implement a calculator that evaluates arithmetic expressions using
LEX (for tokenizing) and YACC (for parsing and evaluation).

## Tools
- flex, bison (YACC-compatible), gcc

## Grammar
```
expr -> expr + expr | expr - expr | expr * expr | expr / expr
      | ( expr ) | - expr (unary) | NUMBER
```
Operator precedence: `*`, `/` bind tighter than `+`, `-`; unary minus
binds tightest.

## Folder Structure
```
Experiment-06-Calculator-LEX-YACC/
├── source/
│   ├── calc.l    (lexer)
│   └── calc.y    (grammar + evaluation actions)
├── input_output/
│   ├── test_input.txt   (7 test expressions)
│   └── exp6_output.txt  (computed results)
├── screenshots/
└── README.md
```

## How to Build & Run
```bash
cd source
bison -d calc.y
flex calc.l
gcc calc.tab.c lex.yy.c -o calculator -lfl
./calculator < ../input_output/test_input.txt
```

## Description
YACC defines operator precedence and associativity (`%left`, `%right`,
`%prec UMINUS`) and computes the result of each expression via
semantic actions. Division by zero is caught and reported without
crashing.

## Result
Successfully evaluated all test expressions, e.g. `3+4*5 = 23`,
`(3+4)*5 = 35`, `-5+10 = 5`, and correctly reported division-by-zero
without terminating the program.
