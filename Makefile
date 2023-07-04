all: calc

parser.tab.c parser.tab.h:	parser.y
	bison -t -v -d parser.y

lex.yy.c: lex.l parser.tab.h
	flex lex.l

calc: lex.yy.c parser.tab.c parser.tab.h
	gcc -o calc parser.tab.c lex.yy.c

clean:
	rm calc parser.tab.c lex.yy.c parser.tab.h parser.output