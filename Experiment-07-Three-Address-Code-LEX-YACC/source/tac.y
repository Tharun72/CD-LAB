%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int temp_count = 1;
char temp_name[10];

char* new_temp() {
    char *name = malloc(10);
    sprintf(name, "t%d", temp_count++);
    return name;
}

int yylex();
void yyerror(const char *s);
%}

%union {
    char *str;
}

%token <str> ID NUMBER
%type <str> expr

%left '+' '-'
%left '*' '/'

%%

program:
    program stmt
    |
    ;

stmt:
    ID '=' expr ';'   { printf("%s = %s\n", $1, $3); }
    ;

expr:
      expr '+' expr   { char *t = new_temp(); printf("%s = %s + %s\n", t, $1, $3); $$ = t; }
    | expr '-' expr   { char *t = new_temp(); printf("%s = %s - %s\n", t, $1, $3); $$ = t; }
    | expr '*' expr   { char *t = new_temp(); printf("%s = %s * %s\n", t, $1, $3); $$ = t; }
    | expr '/' expr   { char *t = new_temp(); printf("%s = %s / %s\n", t, $1, $3); $$ = t; }
    | '(' expr ')'    { $$ = $2; }
    | ID              { $$ = $1; }
    | NUMBER          { $$ = $1; }
    ;

%%

void yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        extern FILE *yyin;
        yyin = fopen(argv[1], "r");
        if (!yyin) { printf("Cannot open file\n"); return 1; }
    }
    printf("===== Three Address Code Generator =====\n\n");
    yyparse();
    return 0;
}
