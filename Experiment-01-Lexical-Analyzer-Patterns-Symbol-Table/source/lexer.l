/*
 * Experiment 1: Using the LEX tool, develop a lexical analyzer to
 * recognize a few patterns in C (identifiers, constants, comments,
 * operators, etc.). Create a symbol table while recognizing identifiers.
 *
 * Author: Abijith U
 * Reg No : 24CS0021
 */

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_SYMBOLS 100

char symtab[MAX_SYMBOLS][50];
int symtab_count = 0;

int lookup(char *name) {
    int i;
    for (i = 0; i < symtab_count; i++) {
        if (strcmp(symtab[i], name) == 0)
            return i;
    }
    return -1;
}

void insert(char *name) {
    if (lookup(name) == -1) {
        strcpy(symtab[symtab_count], name);
        symtab_count++;
    }
}
%}

DIGIT       [0-9]
LETTER      [a-zA-Z_]
ID          {LETTER}({LETTER}|{DIGIT})*
NUMBER      {DIGIT}+(\.{DIGIT}+)?

%%

"/*"([^*]|\*+[^*/])*\*+"/"   { printf("COMMENT       : %s\n", yytext); }
"//".*                        { printf("COMMENT       : %s\n", yytext); }

"int"|"float"|"char"|"double"|"if"|"else"|"while"|"for"|"return"|"void"|"switch"|"case"|"break" {
    printf("KEYWORD       : %s\n", yytext);
}

{ID}        { printf("IDENTIFIER    : %s\n", yytext); insert(yytext); }

{NUMBER}    { printf("CONSTANT      : %s\n", yytext); }

\"([^\\\"]|\\.)*\"  { printf("STRING LITERAL: %s\n", yytext); }

"+"|"-"|"*"|"/"|"%"   { printf("ARITH OP      : %s\n", yytext); }
"="                    { printf("ASSIGN OP     : %s\n", yytext); }
"=="|"!="|"<"|">"|"<="|">=" { printf("RELATIONAL OP : %s\n", yytext); }
"&&"|"\|\|"|"!"        { printf("LOGICAL OP    : %s\n", yytext); }
"("|")"|"{"|"}"|"["|"]" { printf("PUNCTUATION   : %s\n", yytext); }
";"|","                 { printf("PUNCTUATION   : %s\n", yytext); }

[ \t]+      ;  /* skip whitespace */
\n          ;  /* skip newline */

.           { printf("UNKNOWN TOKEN : %s\n", yytext); }

%%

int yywrap() { return 1; }

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            printf("Cannot open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }

    printf("===== Token Stream =====\n");
    yylex();

    printf("\n===== Symbol Table (Identifiers) =====\n");
    printf("%-6s %-20s\n", "No.", "Identifier Name");
    int i;
    for (i = 0; i < symtab_count; i++) {
        printf("%-6d %-20s\n", i + 1, symtab[i]);
    }

    return 0;
}
