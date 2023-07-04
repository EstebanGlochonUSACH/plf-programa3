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

%token IDENTIFICADOR PI EXPONENCIAL DECIMAL ENTERO
%token F_SQR F_CUR F_EXP F_LN F_LOG F_SGN F_INT F_FIX F_FRAC F_ROUND
%token O_SUMA O_RESTA O_MULT O_DIV O_DIVE O_FACT O_MOD
%token O_EXP O_ABS O_PIZQ O_PDER O_IGUAL O_ERR
%token EOL

%left O_SUMA O_RESTA O_EXP O_IGUAL O_MOD
%left O_MULT O_DIV O_DIVE
%right O_FACT

%%

calculo:
    /* empty */ | calculo linea
;
linea:
    EOL |
    expresion EOL |
    asignacion EOL
;
operador_l1:
    O_SUMA | O_RESTA
;
operador_l2:
    O_MULT | O_DIV | O_DIVE | O_MOD
;
func_name:
    F_SQR | F_CUR | F_EXP | F_LN | F_LOG | F_SGN | F_INT | F_FIX | F_FRAC | F_ROUND
;
funcion:
    func_name O_PIZQ expresion O_PDER |
    O_ABS expresion O_ABS
;
op_unidad:
    IDENTIFICADOR | ENTERO | DECIMAL | EXPONENCIAL | PI
;
factorial:
    O_FACT op_unidad |
    O_FACT funcion |
    O_FACT O_PIZQ expresion O_PDER
;
operando:
    op_unidad | funcion | factorial
;
expresion_rama:
    O_PIZQ expresion O_PDER | operando
;
expresion:
    operando |
    O_PIZQ expresion O_PDER |
    expresion_rama operador_l1 expresion |
    expresion_rama operador_l2 expresion |
    expresion_rama O_EXP expresion
;
asignacion:
    IDENTIFICADOR O_IGUAL expresion |
    IDENTIFICADOR O_PIZQ IDENTIFICADOR O_PDER O_IGUAL expresion
;

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

    yyin = fopen(argv[1], "r");
    if(yyin == NULL){
        printf("Error: El archivo no existe.\n");
        return 1;
    }

	do {
		yyparse();
	} while(!feof(yyin));

    fclose(yyin);
    return 0;
};