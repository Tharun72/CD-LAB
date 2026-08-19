# Experiment 1 — Lexical Analyzer to Recognize Patterns in C + Symbol Table

## Aim
Using the LEX tool, develop a lexical analyzer to recognize a few patterns
in C (identifiers, constants, comments, operators, etc.), and create a
symbol table while recognizing identifiers.

## Tools
- flex (Fast Lexical Analyzer Generator)
- gcc

## Folder Structure
```
Experiment-01-Lexical-Analyzer-Patterns-Symbol-Table/
├── source/lexer.l
├── input_output/
│   ├── test_input.c      (input: sample C program)
│   └── exp1_output.txt   (output: token stream + symbol table)
├── screenshots/
└── README.md
```

## How to Build & Run
```bash
cd source
flex lexer.l
gcc lex.yy.c -o lexer -lfl
./lexer ../input_output/test_input.c
```

## Description
The LEX specification recognizes:
- Comments (`/* ... */` and `//...`)
- Keywords (`int`, `float`, `if`, `else`, `while`, ...)
- Identifiers — inserted into an in-memory symbol table (duplicates skipped)
- Numeric constants (integer and floating point)
- String literals
- Arithmetic, assignment, relational, and logical operators
- Punctuation symbols

After scanning, the program prints the full token stream followed by
the symbol table of all unique identifiers found.

## Result
Successfully implemented a lexical analyzer that classifies every token
in a sample C program and builds a symbol table of identifiers.
