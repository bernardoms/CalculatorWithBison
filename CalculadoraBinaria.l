
%{
//Usar valores > que 257 pois estes sao reservados pelo bison
#include "ParserCalculadoraBinaria.tab.h"
#define YYDEBUG 1

extern int yylval;
%}
/* Definições */

%%
[0-1]+ { yylval = atoi(yytext); return T_DIGIT; } // Recebe digitos de 0-9, e passa para o parser
"+" { return T_PLUS; }
"-" { return T_MINUS; }
"*" { return T_MULT; }
"/" { return T_DIV; }
"\n" { return T_NEWLINE; }
[ \t] ; //Ignora espaco em branco
"sair" { return T_SAIDA; }
.        { return *yytext; }
%%
