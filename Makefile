program_exe = calc
bison_filename = parser
flex_file = lex.l

all: $(program_exe)

$(bison_filename).tab.c $(bison_filename).tab.h: $(bison_filename).y
	bison -t -v -d $(bison_filename).y

lex.yy.c: $(flex_file) $(bison_filename).tab.h
	flex $(flex_file)

$(program_exe): lex.yy.c $(bison_filename).tab.c $(bison_filename).tab.h
	gcc -o $(program_exe) $(bison_filename).tab.c lex.yy.c

clean:
	rm $(program_exe) $(bison_filename).tab.c lex.yy.c $(bison_filename).tab.h $(bison_filename).output