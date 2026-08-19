# Experiment 4 — Recognize a Valid Variable Name

## Aim
Write a program to recognize a valid variable which starts with a
letter followed by any number of letters or digits.

## Tools
- flex, gcc

## Rule
```
variable -> letter (letter | digit)*
```

## Folder Structure
```
Experiment-04-Valid-Variable-Recognition/
├── source/valid_var.l
├── input_output/
│   ├── test_input.txt    (10 candidate names, one per line)
│   └── exp4_output.txt   (VALID/INVALID verdict for each)
├── screenshots/
└── README.md
```

## How to Build & Run
```bash
cd source
flex valid_var.l
gcc lex.yy.c -o valid_var -lfl
./valid_var < ../input_output/test_input.txt
```

## Description
Each line of input is matched against three whole-line patterns (using
`^...$` anchors): starts-with-letter (VALID), starts-with-digit
(INVALID), or contains any other illegal character (INVALID). This
correctly flags cases like `2ndValue` (starts with digit), `var$name`
(illegal character), and `my-var` (hyphen not allowed) as invalid.

## Result
Successfully tested 10 candidate variable names; the recognizer
correctly classified each as valid or invalid per the given rule.
