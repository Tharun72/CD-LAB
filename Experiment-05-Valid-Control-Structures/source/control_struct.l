/*
 * Experiment 5: Program to recognize a valid control structure syntax
 * of C language (for loop, while loop, if-else, if-else-if, switch-case).
 *
 * Approach: LEX recognizes the keyword and its surrounding syntactic
 * skeleton using regular expressions tuned to each control structure's
 * required shape (matching parentheses/braces pattern), and reports
 * which construct was matched.
 *
 * Author: Abijith U
 * Reg No : 24CS0021
 */

%{
#include <stdio.h>
%}

WS   [ \t\n]*
COND \([^()]*\)

%%

"for"{WS}{COND}{WS}"{"    { printf("VALID   : FOR loop      -> %s\n", yytext); }

"while"{WS}{COND}{WS}"{"  { printf("VALID   : WHILE loop    -> %s\n", yytext); }

"if"{WS}{COND}{WS}"{"{WS}"}"{WS}"else"{WS}"if"{WS}{COND}{WS}"{" {
    printf("VALID   : IF-ELSE-IF   -> %s\n", yytext);
}

"if"{WS}{COND}{WS}"{"{WS}"}"{WS}"else"{WS}"{" {
    printf("VALID   : IF-ELSE      -> %s\n", yytext);
}

"if"{WS}{COND}{WS}"{"     { printf("VALID   : IF (simple)   -> %s\n", yytext); }

"switch"{WS}{COND}{WS}"{"{WS}("case"[^:]*":")+  {
    printf("VALID   : SWITCH-CASE  -> %s\n", yytext);
}

"for"|"while"|"if"|"else"|"switch"|"case" {
    printf("INVALID : malformed '%s' construct (missing condition/braces)\n", yytext);
}

.|\n    ;

%%

int yywrap() { return 1; }

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *f = fopen(argv[1], "r");
        if (!f) { printf("Cannot open file\n"); return 1; }
        yyin = f;
    }
    printf("===== Control Structure Syntax Validator =====\n\n");
    yylex();
    return 0;
}
