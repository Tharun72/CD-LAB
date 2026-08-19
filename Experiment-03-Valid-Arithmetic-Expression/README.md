# Experiment 3 — Recognize a Valid Arithmetic Expression

## Aim
Write a program to recognize a valid arithmetic expression that uses
the operators +, -, *, and /.

## Tools
- flex, gcc

## Grammar
```
expr   -> term ((+|-) term)*
term   -> factor ((*|/) factor)*
factor -> IDENTIFIER | NUMBER | ( expr )
```

## Folder Structure
```
Experiment-03-Valid-Arithmetic-Expression/
├── source/arith_expr.l
├── input_output/exp3_output.txt   (output for 7 built-in test expressions)
├── screenshots/
└── README.md
```

## How to Build & Run
```bash
cd source
flex arith_expr.l
gcc lex.yy.c -o arith_expr -lfl
./arith_expr
```
(Test expressions are defined directly in the source for convenience;
edit the `test_expressions[]` array in `arith_expr.l` to try your own.)

## Description
LEX tokenizes each candidate expression, and a hand-written recursive-
descent parser (implementing the grammar above) walks the token stream
to determine validity. Invalid inputs — unbalanced parentheses,
consecutive operators, illegal characters — are correctly rejected.

## Result
Successfully validated 7 test expressions; the validator correctly
accepted well-formed expressions (including nested parentheses) and
rejected malformed ones.
