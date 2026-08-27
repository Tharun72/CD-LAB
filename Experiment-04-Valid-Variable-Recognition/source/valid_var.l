%{
#include <stdio.h>
%}

%%

^[a-zA-Z][a-zA-Z0-9]*$   { printf("%-15s -> VALID variable name\n", yytext); }
^[0-9][a-zA-Z0-9]*$       { printf("%-15s -> INVALID (starts with a digit)\n", yytext); }
^.+$                       { printf("%-15s -> INVALID (illegal character present)\n", yytext); }
\n                       ;

%%

int yywrap() { return 1; }

int main() {
    printf("===== Valid Variable Name Recognizer =====\n");
    printf("(Enter each candidate variable name on its own line; reading from input file)\n\n");
    yylex();
    return 0;
}
