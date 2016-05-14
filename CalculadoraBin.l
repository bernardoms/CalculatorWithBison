%{
#define T_DIGIT 258
#define T_PLUS 259
#define T_EQUALS 260
extern int yylval;
%}
/* Definições */

%%
[0-9]+ { yylval = atoi(yytext); return T_DIGIT; } // Recebe digitos de 0-9, e passa para o parcer
"+" { return T_PLUS; }
"=" { return T_EQUALS; }
<<EOF>> {return 0;}

%%
