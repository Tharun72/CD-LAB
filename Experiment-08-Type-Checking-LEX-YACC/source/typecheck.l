/*
 * Lexical analyzer for the type checker (Experiment 8).
 */

%{
#include "typecheck.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

"int"                      { return INT_TYPE; }
"float"                    { return FLOAT_TYPE; }
[0-9]+\.[0-9]+              { yylval.str = strdup(yytext); return FLOAT_CONST; }
[0-9]+                       { yylval.str = strdup(yytext); return INT_CONST; }
[a-zA-Z_][a-zA-Z0-9_]*       { yylval.str = strdup(yytext); return ID; }
[+*=;]                        { return yytext[0]; }
[ \t\n]                        ;
.                                ;

%%

int yywrap() { return 1; }
