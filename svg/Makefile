svg.parser.c: svg.y
	bison -d svg.y -o $@

svg.lex.c: svg.l
	flex svg.l

svgo: svg.parser.c svg.lex.c
	gcc -o $@ svg.parser.c svg.lex.c

clean:
	rm svg.lex.h svg.lex.c svg.parser.c svg.parser.h svgo