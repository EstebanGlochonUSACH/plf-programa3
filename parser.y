%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <unistd.h>
#ifdef WIN32
#include <io.h>
#define F_OK 0
#define access _access
#endif

int file_exists(char *filename) {
    if (access(filename, F_OK) == 0) return 0;
    return 1;
};

extern int yylineno;
extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(char *s);
%}

%token IDENTIFICADOR
%token PI EXPONENCIAL DECIMAL ENTERO
%token SQR CUR EXP LN LOG SGN INT FIX FRAC ROUND
%token O_SUMA O_RESTA O_MULT O_DIV O_DIVE O_FACT O_MOD
%token O_EXP O_ABS O_PIZQ O_PDER O_IGUAL O_ERR

%left O_SUMA O_RESTA O_EXP O_IGUAL
%left O_MULT O_DIV O_DIVE
%right O_FACT

%%

calculo:
    /* empty */ | calculo linea
;
linea:
    expresion
;
operando:
    ENTERO | DECIMAL | EXPONENCIAL | PI | IDENTIFICADOR
;
expresion:
    expresion_simple O_SUMA expresion |
    expresion_simple O_RESTA expresion |
    expresion_simple O_MULT expresion |
    expresion_simple O_DIV expresion |
    expresion_simple O_DIVE expresion |
    expresion_simple O_MOD expresion |
    expresion_simple O_EXP expresion |
    O_PIZQ expresion_simple O_PDER
;
expresion_simple:
    operando |
    operando O_SUMA operando |
    operando O_RESTA operando |
    operando O_MULT operando |
    operando O_DIV operando |
    operando O_DIVE operando |
    operando O_MOD operando |
    operando O_EXP operando |
    O_PIZQ operando O_PDER
;
/*expresion:
    expresion_l1 | expresion_l2 | expresion_l3 | expresion_l4
;
factorial:
    '!' ENTERO
;
vabsoluto:
    '|' expresion '|'
;
funcion:
    SQR | CUR | EXP | LN | LOG | SGN | INT | FIX | FRAC | ROUND
;
exprfunc:
    funcion '(' expresion ')'
;
operando:
    ENTERO | DECIMAL | EXPONENCIAL | PI | IDENTIFICADOR |
    factorial | vabsoluto | exprfunc | expresion
;
expresion_l1:
    operando '+' operando |
    operando '-' operando
;
expresion_l2:
    operando 'x' operando |
    operando '/' operando |
    operando ':' operando |
    operando MOD operando
;
expresion_l3:
    operando '^' operando
;
expresion_l4:
    '(' expresion ')'
;*/
/*asignacion:
    IDENTIFICADOR '=' expresion |
    IDENTIFICADOR '(' IDENTIFICADOR ')' '=' expresion
;*/

%%

void yyerror(char *s)
{
    printf("Error en la l%cnea n%cumero: %d\n", 161, 163, yylineno);
    exit(1);
}

int main(int argc, char *argv[])
{
    if(argc == 1){
        printf("Error: Falta par%cmetro.\n", 160);
        printf("Uso: %s archivo\n", argv[0]);
        return 1;
    }
    else if(argc > 2){
        printf("Error: Demasiados par%cmetros.\n", 160);
        printf("Uso: %s archivo\n", argv[0]);
        return 1;
    }

    // yyin = fopen(argv[1], "r");
    // if(yyin == NULL){
    //     printf("Error: El archivo no existe.\n");
    //     return 1;
    // }

	yyin = stdin;
	do {
		yyparse();
	} while(!feof(yyin));

    // fclose(yyin);
    return 0;
};