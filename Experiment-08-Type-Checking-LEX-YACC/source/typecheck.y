%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_VARS 100

typedef struct {
    char name[50];
    char type[10];  /* "int" or "float" */
} VarEntry;

VarEntry symtab[MAX_VARS];
int var_count = 0;

char* get_type(char *name) {
    int i;
    for (i = 0; i < var_count; i++) {
        if (strcmp(symtab[i].name, name) == 0) return symtab[i].type;
    }
    return NULL;
}

void declare_var(char *type, char *name) {
    if (get_type(name) != NULL) {
        printf("Error: variable '%s' already declared\n", name);
        return;
    }
    strcpy(symtab[var_count].name, name);
    strcpy(symtab[var_count].type, type);
    var_count++;
    printf("Declared: %s %s\n", type, name);
}

int yylex();
void yyerror(const char *s);
%}

%union { char *str; }

%token <str> ID INT_TYPE FLOAT_TYPE INT_CONST FLOAT_CONST
%type <str> expr

%%

program:
    program stmt
    |
    ;

stmt:
      INT_TYPE ID ';'         { declare_var("int", $2); }
    | FLOAT_TYPE ID ';'       { declare_var("float", $2); }
    | ID '=' expr ';'         {
          char *lhs_type = get_type($1);
          if (lhs_type == NULL) {
              printf("Error: variable '%s' not declared\n", $1);
          } else if (strcmp(lhs_type, "int") == 0 && strcmp($3, "float") == 0) {
              printf("Type Error: cannot assign FLOAT value to INT variable '%s'\n", $1);
          } else {
              printf("OK: %s (%s) = expression of type %s\n", $1, lhs_type, $3);
          }
      }
    ;

expr:
      expr '+' expr {
          if (strcmp($1, "float") == 0 || strcmp($3, "float") == 0) $$ = "float";
          else $$ = "int";
      }
    | expr '*' expr {
          if (strcmp($1, "float") == 0 || strcmp($3, "float") == 0) $$ = "float";
          else $$ = "int";
      }
    | ID {
          char *t = get_type($1);
          if (t == NULL) { printf("Error: variable '%s' not declared\n", $1); $$ = "int"; }
          else $$ = t;
      }
    | INT_CONST    { $$ = "int"; }
    | FLOAT_CONST  { $$ = "float"; }
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
    printf("===== Type Checker using LEX and YACC =====\n\n");
    yyparse();
    return 0;
}
