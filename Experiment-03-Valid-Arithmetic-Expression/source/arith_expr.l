/*
 * Experiment 3: Program to recognize a valid arithmetic expression
 * that uses operators +, -, *, and /.
 *
 * Grammar (simplified, left-recursion free for a lexer-level check):
 *   expr   -> term ((+|-) term)*
 *   term   -> factor ((*|/) factor)*
 *   factor -> IDENTIFIER | NUMBER | ( expr )
 *
 * This LEX program tokenizes the input and a small recursive-descent
 * validator (in C, driven by the LEX-generated token stream) checks
 * whether the full expression is syntactically valid.
 *
 * Author: Abijith U
 * Reg No : 24CS0021
 */

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ID 1
#define NUM 2
#define PLUS 3
#define MINUS 4
#define MUL 5
#define DIV 6
#define LPAREN 7
#define RPAREN 8
#define END 9
#define INVALID 10

int tokens[500];
char lexemes[500][50];
int token_count = 0;
%}

%%

[a-zA-Z_][a-zA-Z0-9_]*  { tokens[token_count] = ID; strcpy(lexemes[token_count], yytext); token_count++; }
[0-9]+(\.[0-9]+)?       { tokens[token_count] = NUM; strcpy(lexemes[token_count], yytext); token_count++; }
"+"                      { tokens[token_count] = PLUS; strcpy(lexemes[token_count], yytext); token_count++; }
"-"                      { tokens[token_count] = MINUS; strcpy(lexemes[token_count], yytext); token_count++; }
"*"                      { tokens[token_count] = MUL; strcpy(lexemes[token_count], yytext); token_count++; }
"/"                      { tokens[token_count] = DIV; strcpy(lexemes[token_count], yytext); token_count++; }
"("                      { tokens[token_count] = LPAREN; strcpy(lexemes[token_count], yytext); token_count++; }
")"                      { tokens[token_count] = RPAREN; strcpy(lexemes[token_count], yytext); token_count++; }
[ \t]+      ;
\n          ;
.           { tokens[token_count] = INVALID; strcpy(lexemes[token_count], yytext); token_count++; }

%%

int pos = 0;

int factor();
int term();
int expr();

int factor() {
    if (pos >= token_count) return 0;
    if (tokens[pos] == ID || tokens[pos] == NUM) {
        pos++;
        return 1;
    } else if (tokens[pos] == LPAREN) {
        pos++;
        if (!expr()) return 0;
        if (pos >= token_count || tokens[pos] != RPAREN) return 0;
        pos++;
        return 1;
    }
    return 0;
}

int term() {
    if (!factor()) return 0;
    while (pos < token_count && (tokens[pos] == MUL || tokens[pos] == DIV)) {
        pos++;
        if (!factor()) return 0;
    }
    return 1;
}

int expr() {
    if (!term()) return 0;
    while (pos < token_count && (tokens[pos] == PLUS || tokens[pos] == MINUS)) {
        pos++;
        if (!term()) return 0;
    }
    return 1;
}

int yywrap() { return 1; }

void validate_expression(char *line) {
    token_count = 0;
    pos = 0;
    yy_scan_string(line);
    yylex();

    printf("\nExpression: %s\n", line);
    printf("Tokens    : ");
    int i;
    for (i = 0; i < token_count; i++) {
        printf("%s ", lexemes[i]);
    }
    printf("\n");

    int has_invalid = 0;
    for (i = 0; i < token_count; i++) {
        if (tokens[i] == INVALID) has_invalid = 1;
    }

    if (has_invalid) {
        printf("Result    : INVALID (contains illegal character)\n");
        return;
    }

    int valid = expr();
    if (valid && pos == token_count) {
        printf("Result    : VALID arithmetic expression\n");
    } else {
        printf("Result    : INVALID arithmetic expression\n");
    }
}

int main() {
    char *test_expressions[] = {
        "a + b * c",
        "(a + b) * (c - d)",
        "x1 + 25 / y2",
        "a + + b",
        "(a + b",
        "a * (b + c) - d / e",
        "3 @ 4"
    };
    int n = sizeof(test_expressions) / sizeof(test_expressions[0]);
    int i;

    printf("===== Arithmetic Expression Validator =====\n");
    for (i = 0; i < n; i++) {
        validate_expression(test_expressions[i]);
    }

    return 0;
}
