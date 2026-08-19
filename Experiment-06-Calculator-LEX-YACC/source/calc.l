/*
 * Lexical analyzer for the calculator (Experiment 6).
 */

%{
#include "calc.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[-+*/()]    { return yytext[0]; }
\n          { return '\n'; }
[ \t]       ;
.           { /* ignore unknown characters */ }

%%

int yywrap() { return 1; }
