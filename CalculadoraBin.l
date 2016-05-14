%{
#define T_DIGIT 258
#define T_PLUS 258
extern int yylval;
%}
/* Definições */
DIGITS [0-9]+;
%%
{DIGITS} { yylval = atoi(yytext); return T_DIGIT; }
"+" {return T_PLUS;}
<<EOF>> {return 0;}

%%
