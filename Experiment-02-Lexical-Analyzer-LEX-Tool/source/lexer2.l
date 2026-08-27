
%{
#include <stdio.h>

int num_keywords = 0, num_identifiers = 0, num_numbers = 0;
int num_operators = 0, num_special = 0, num_lines = 1;
%}

%%

"int"|"float"|"char"|"double"|"if"|"else"|"while"|"for"|"return"|"void" {
    num_keywords++;
    printf("%-15s -> KEYWORD\n", yytext);
}

[a-zA-Z_][a-zA-Z0-9_]*  {
    num_identifiers++;
    printf("%-15s -> IDENTIFIER\n", yytext);
}

[0-9]+(\.[0-9]+)?   {
    num_numbers++;
    printf("%-15s -> NUMBER\n", yytext);
}

"+"|"-"|"*"|"/"|"="|"<"|">"|"<="|">="|"=="|"!=" {
    num_operators++;
    printf("%-15s -> OPERATOR\n", yytext);
}

[(){};,\[\]]  {
    num_special++;
    printf("%-15s -> SPECIAL SYMBOL\n", yytext);
}

\n          { num_lines++; }
[ \t]+      ;

.           ;

%%

int yywrap() { return 1; }

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) { printf("Cannot open file\n"); return 1; }
        yyin = file;
    }

    printf("===== Token Classification =====\n");
    yylex();

    printf("\n===== Summary =====\n");
    printf("Total Lines       : %d\n", num_lines);
    printf("Keywords          : %d\n", num_keywords);
    printf("Identifiers       : %d\n", num_identifiers);
    printf("Numbers           : %d\n", num_numbers);
    printf("Operators         : %d\n", num_operators);
    printf("Special Symbols   : %d\n", num_special);

    return 0;
}
