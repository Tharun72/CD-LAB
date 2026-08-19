# Experiment 5 — Recognize Valid Control Structure Syntax of C

## Aim
Write a program to recognize a valid control structure syntax of the C
language (for loop, while loop, if-else, if-else-if, switch-case).

## Tools
- flex, gcc

## Folder Structure
```
Experiment-05-Valid-Control-Structures/
├── source/control_struct.l
├── input_output/
│   ├── test_input.c      (sample control structures, some malformed)
│   └── exp5_output.txt   (VALID/INVALID classification per construct)
├── screenshots/
└── README.md
```

## How to Build & Run
```bash
cd source
flex control_struct.l
gcc lex.yy.c -o control_struct -lfl
./control_struct ../input_output/test_input.c
```

## Description
LEX patterns match the opening syntactic skeleton of each control
structure — `for(...)`{, `while(...)`{, `if(...)`{, chained
`if(...){ } else if(...){`, `if(...){ } else {`, and
`switch(...){ case X: ...` — and report each as VALID when the pattern
is well-formed, or INVALID when a keyword appears without its required
condition/braces (e.g. `for i = 0 to 10 {`, a bare `if` on a line by
itself before a non-brace body).

## Result
Successfully validated for-loops, while-loops, if-else, if-else-if,
and switch-case constructs, correctly distinguishing well-formed
syntax from malformed control structures.
