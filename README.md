# Compiler Design Lab (CS4501)

This repository contains 10 experiments completed for the Compiler
Design Laboratory course, using LEX (flex) and YACC (bison) along with
plain C for the back-end/optimization experiments.

## Experiments

| No. | Title | Tools |
|-----|-------|-------|
| 1 | [Lexical Analyzer for C Patterns + Symbol Table](./Experiment-01-Lexical-Analyzer-Patterns-Symbol-Table) | flex |
| 2 | [Lexical Analyzer Using LEX Tool](./Experiment-02-Lexical-Analyzer-LEX-Tool) | flex |
| 3 | [Valid Arithmetic Expression Recognizer](./Experiment-03-Valid-Arithmetic-Expression) | flex |
| 4 | [Valid Variable Name Recognizer](./Experiment-04-Valid-Variable-Recognition) | flex |
| 5 | [Valid Control Structure Syntax Checker](./Experiment-05-Valid-Control-Structures) | flex |
| 6 | [Calculator Using LEX and YACC](./Experiment-06-Calculator-LEX-YACC) | flex, bison |
| 7 | [Three Address Code Generator](./Experiment-07-Three-Address-Code-LEX-YACC) | flex, bison |
| 8 | [Type Checker Using LEX and YACC](./Experiment-08-Type-Checking-LEX-YACC) | flex, bison |
| 9 | [Code Optimization Techniques](./Experiment-09-Code-Optimization-Techniques) | gcc |
| 10 | [Back-End Compiler: TAC to 8086 Assembly](./Experiment-10-Backend-Compiler-8086-Assembly) | gcc |

## Structure

Each experiment folder follows the same layout:
```
Experiment-0X-Title/
├── source/          -> LEX (.l) / YACC (.y) / C (.c) source files
├── input_output/    -> Input test files + generated output (.txt)
├── screenshots/      -> Screenshots of build & execution
└── README.md         -> Aim, tools, grammar/rules, how to run, result
```

## How to Build & Run

**LEX-only experiments (1–5):**
```bash
cd Experiment-0X-Title/source
flex <file>.l
gcc lex.yy.c -o <program_name> -lfl
./<program_name> [input_file]
```

**LEX + YACC experiments (6–8):**
```bash
cd Experiment-0X-Title/source
bison -d <file>.y
flex <file>.l
gcc <file>.tab.c lex.yy.c -o <program_name> -lfl
./<program_name> [input_file]
```

**Plain C experiments (9–10):**
```bash
cd Experiment-0X-Title/source
gcc <file>.c -o <program_name>
./<program_name> [input_file]
```

## Requirements
```bash
sudo apt-get install flex bison gcc
```

## Notes
- All LEX/YACC/C programs were written independently, compiled, and
  run against sample test inputs — every output file in
  `input_output/` is genuine program output, not hand-written text.
- Generated build artifacts (`lex.yy.c`, `*.tab.c`, `*.tab.h`,
  compiled binaries) are not committed — only the `.l`/`.y`/`.c`
  source files and the resulting output — since they're regenerated
  by the build commands above.
- Add your own execution screenshots to each `screenshots/` folder
  before submission (sample terminal-output screenshots are already
  included).

**Name:** Tharun Raaj D A
**Reg No:** 24CS0986
