/*
 * Experiment 6: Implementation of a calculator using LEX and YACC.
 * Supports +, -, *, /, parentheses, and unary minus on integers.
 *
 * Author: Abijith U
 * Reg No : 24CS0021
 */

%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%right UMINUS

%%

program:
    program expr '\n'   { printf("Result = %d\n", $2); }
    | program '\n'
    |
    ;

expr:
      expr '+' expr     { $$ = $1 + $3; }
    | expr '-' expr     { $$ = $1 - $3; }
    | expr '*' expr     { $$ = $1 * $3; }
    | expr '/' expr     {
                           if ($3 == 0) { printf("Error: Division by zero\n"); $$ = 0; }
                           else $$ = $1 / $3;
                         }
    | '(' expr ')'      { $$ = $2; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | NUMBER             { $$ = $1; }
    ;

%%

void yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
}

int main() {
    printf("===== Calculator using LEX and YACC =====\n");
    printf("Enter arithmetic expressions (one per line):\n\n");
    yyparse();
    return 0;
}
