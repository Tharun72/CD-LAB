# Experiment 2 — Implement a Lexical Analyzer Using LEX Tool

## Aim
Implement a lexical analyzer using the LEX tool that classifies tokens
into keywords, identifiers, numbers, operators, and special symbols,
and reports a summary count of each category.

## Tools
- flex
- gcc

## Folder Structure
```
Experiment-02-Lexical-Analyzer-LEX-Tool/
├── source/lexer2.l
├── input_output/
│   ├── test_input.txt    (input source code snippet)
│   └── exp2_output.txt   (output: classified tokens + summary)
├── screenshots/
└── README.md
```

## How to Build & Run
```bash
cd source
flex lexer2.l
gcc lex.yy.c -o lexer2 -lfl
./lexer2 ../input_output/test_input.txt
```

## Description
Reads a small program (variable declarations, assignments, an `if`, and
a `while` loop) and classifies every token as KEYWORD, IDENTIFIER,
NUMBER, OPERATOR, or SPECIAL SYMBOL, printing a running classification
followed by total counts per category and total line count.

## Result
Successfully built a lexical analyzer that classifies and counts all
token types in the input program.
