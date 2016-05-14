%{
#include <stdio.h>
#include <stdlib.h>
extern FILE* yyin;
int yylex();
void yyerror(const char *s);
%}
 

%token T_DIGIT 
%token T_PLUS
%left T_PLUS // Forca o parser a ir para a direita da arvore ao ver uma soma
%start calculation

%%
// Inicio das Producoes
calculation : 
|calculation statment
;

statment : T_DIGIT  {$$ = $1; }
|statment T_PLUS statment { $$ = $1 + $3; }
|"=" { printf("\tResult: %i\n", $1); }
;
//Fim das Producoes
%%


int main() {
    yyin = stdin;
    do
    {
    	yyparse();
    }while(!feof(yyin));
    return 0;
    
}

int yywrap(){ //Funcao necessaria para nao dar erro de referencia ao yywrap
	return 1;
}

void yyerror(const char* errmsg)//Printa msg de erro
{
	printf("\n*** Erro: %s\n", errmsg);
}