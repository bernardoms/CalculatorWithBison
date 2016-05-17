//Trabalho de Compiladores - CEFET - RJ Por Bernardo Monteiro da Silva



%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ParserCalculadoraBinaria.tab.h"

int yylex();
void yyerror(char *);
extern int yylineno;
extern char* yytext;
void transformaBin(int val);
int binaryToDecimal(int val);

%}
 

%token T_DIGIT
%token T_PLUS T_MINUS
%token T_DIV T_MULT 
%token T_NEWLINE
%token T_SAIDA





%left T_PLUS T_MINUS T_MULT T_DIV// Forca o parser a ir para a direita da arvore ao ver uma soma
%start calculation //Diz por qual producao iniciar

%%



/* Pequena Explicacao dos simbolos utilizados pelo bison:
$$ = inicio do stack
$1 = primeiro elemento do stack
$3 = terceiro elemento do stack
*/

/* Trecho de codigo para debugar, isso aqui salva vidas!!!!
#if YYDEBUG == 1
	extern int yydebug;
	yydebug = 1;
	#endif
*/

// Inicio das Producoes

calculation: 
 |calculation line 
;

line:
	T_NEWLINE
	|expr T_NEWLINE {transformaBin($$)};
	|T_SAIDA { printf("Saindo..."); exit(0); }
	;
	
expr: 
	T_DIGIT  { $$ = $1; }
| expr T_PLUS expr { $$ = binaryToDecimal($1) + binaryToDecimal($3) ; }
| expr T_MINUS expr { $$ = binaryToDecimal($1) - binaryToDecimal($3); }
| expr T_MULT expr { $$ = binaryToDecimal($1) * binaryToDecimal($3); }
| expr T_DIV expr { $$ = binaryToDecimal($1) / binaryToDecimal($3); }
;





//Fim das Producoes
%%

//Transforma decimal para binario
void transformaBin(int val){
    int rem, i=1, binario=0;
    while (val!=0)
    {
        rem=val%2;
        val/=2;
        binario+=rem*i;
        i*=10;
    }
    printf("Result = %d\n", binario);
}

//Transforma de binario para decimal
int binaryToDecimal(int val)
{
	int decimal=0, i=0, rem;
    while (val!=0)
    {
        rem = val%10;
        val/=10;
        decimal += rem*pow(2,i);
        ++i;
    }
    //printf("%i",decimal);
    return decimal;	
}

int main() {
	
    yyparse();
    return 0;
    
}

int yywrap(void){ //Funcao necessaria para nao dar erro de referencia ao yywrap
	return 1;
}

void yyerror(char* errmsg)//Printa msg de erro
{
	fprintf(stderr, "%d: Erro do Tipo: '%s' na linha '%s'\n", yylineno, errmsg, yytext);
}
