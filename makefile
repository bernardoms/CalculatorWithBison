calc: ParserCalculadoraBinaria.y CalculadoraBinaria.l
	bison -d ParserCalculadoraBinaria.y
	flex  -o CalculadoraBinaria.l.c CalculadoraBinaria.l
	gcc  -o calc CalculadoraBinaria.l.c ParserCalculadoraBinaria.tab.c -ll -lm 