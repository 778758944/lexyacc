caculator: parser.c lex.c
	gcc parser.c lex.c -o caculator

parser.c: caculator.yacc
	bison -dy caculator.yacc -o parser.c

lex.c: caculator.lex
	flex -o lex.c caculator.lex

clean:
	rm parser.h parser.c lex.c