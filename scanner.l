%option noyywrap
%option noinput
%option nounput

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

extern void yyerror(const char *s);
int line_number = 1;
%}

DIGITO      [0-9]
ELEMENTO    {DIGITO}+([.]{DIGITO}+|-{DIGITO}+)*

%%
"<IB>"          { return INICIO_BLOQUE; }
"<FB>"          { return FIN_BLOQUE; }
"$A"            { return INICIO_CADENA; }
"$Z"            { return FIN_CADENA; }
[a-z]           { yylval.letra = yytext[0]; return LETRA; }
"#"             { return OP_HASH; }
"%"             { return OP_PERCENT; }
"?"             { return OP_QUESTION; }
"@"             { return OP_AT; }
{ELEMENTO}      { yylval.elemento = strdup(yytext); return ELEMENTO; }
[ \t\r]         ; /* Ignorar espacios en blanco */
\n              { line_number++; }
.               { 
                    char msg[100];
                    sprintf(msg, "Error léxico: cadena desconocida: %s", yytext);
                    yyerror(msg);
                }
%%
