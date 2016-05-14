
%{
//Usar valores > que 257 pois estes sao reservados pelo bison
#define T_DIGIT 258
#define T_PLUS 259
#define T_EQUALS 260
#define T_SAIDA 261
#define T_MINUS 262
#define T_MULT 264
#define T_DIV 263

extern int yylval;
%}
/* Definições */

%%
[0-1]+ { yylval = atoi(yytext); return T_DIGIT; } // Recebe digitos de 0-9, e passa para o parser
"+" { return T_PLUS; }
"=" { return T_EQUALS; }
"-" { return T_MINUS; }
"*" { return T_MULT; }
"/" { return T_DIV; }
[ \t] ; //Ignora espaco em branco
"sair" { return T_SAIDA; }
\n { return 0; } //ao encontrar uma nova linha sair do programa
%%
