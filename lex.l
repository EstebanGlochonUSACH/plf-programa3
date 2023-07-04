%{
#include <stdio.h>
#define YY_DECL int yylex()
#include "parser.tab.h"

int return_simbolo(char simbol);

%}

%option noyywrap
%option yylineno

%s PI
%s MOD
%s SQR
%s CUR
%s EXP
%s LN
%s LOG
%s SGN
%s INT
%s FIX
%s FRAC
%s ROUND
%s CHARX

SIMBOLOS     "+"|"-"|":"|"/"|"^"|"|"|"!"|"("|")"|"="
IGNORE_CHAR  \n|\t|.

%%

"x"                                    {BEGIN(CHARX);}
<CHARX>[a-zA-Z][a-zA-Z0-9]*            {BEGIN(INITIAL); return IDENTIFICADOR;}
<CHARX>({SIMBOLOS})                    {BEGIN(INITIAL); unput(yytext[0]); return O_MULT;}
<CHARX>({IGNORE_CHAR})                 {BEGIN(INITIAL); return O_MULT;}
<CHARX><<EOF>>                         {BEGIN(INITIAL); return O_MULT;}
<INITIAL>"PI"                          {BEGIN(PI);}
<PI>[a-zA-Z0-9]+                       {BEGIN(INITIAL); return IDENTIFICADOR;}
<PI>({SIMBOLOS})                       {BEGIN(INITIAL); unput(yytext[0]); return PI;}
<PI>({IGNORE_CHAR})                    {BEGIN(INITIAL); return PI;}
<PI><<EOF>>                            {BEGIN(INITIAL); return PI;}
<INITIAL>"MOD"                         {BEGIN(MOD);}
<MOD>[a-zA-Z0-9]+                      {BEGIN(INITIAL); return IDENTIFICADOR;}
<MOD>({SIMBOLOS})                      {BEGIN(INITIAL); unput(yytext[0]); return O_MOD;}
<MOD>({IGNORE_CHAR})                   {BEGIN(INITIAL); return O_MOD;}
<MOD><<EOF>>                           {BEGIN(INITIAL); return O_MOD;}
<INITIAL>"SQR"                         {BEGIN(SQR);}
<SQR>[a-zA-Z0-9]+                      {BEGIN(INITIAL); return IDENTIFICADOR;}
<SQR>({SIMBOLOS})                      {BEGIN(INITIAL); unput(yytext[0]); return SQR;}
<SQR>({IGNORE_CHAR})                   {BEGIN(INITIAL); return SQR;}
<SQR><<EOF>>                           {BEGIN(INITIAL); return SQR;}
<INITIAL>"CUR"                         {BEGIN(CUR);}
<CUR>[a-zA-Z0-9]+                      {BEGIN(INITIAL); return IDENTIFICADOR;}
<CUR>({SIMBOLOS})                      {BEGIN(INITIAL); unput(yytext[0]); return CUR;}
<CUR>({IGNORE_CHAR})                   {BEGIN(INITIAL); return CUR;}
<CUR><<EOF>>                           {BEGIN(INITIAL); return CUR;}
<INITIAL>"EXP"                         {BEGIN(EXP);}
<EXP>[a-zA-Z0-9]+                      {BEGIN(INITIAL); return IDENTIFICADOR;}
<EXP>({SIMBOLOS})                      {BEGIN(INITIAL); unput(yytext[0]); return EXP;}
<EXP>({IGNORE_CHAR})                   {BEGIN(INITIAL); return EXP;}
<EXP><<EOF>>                           {BEGIN(INITIAL); return EXP;}
<INITIAL>"LN"                          {BEGIN(LN);}
<LN>[a-zA-Z0-9]+                       {BEGIN(INITIAL); return IDENTIFICADOR;}
<LN>({SIMBOLOS})                       {BEGIN(INITIAL); unput(yytext[0]); return LN;}
<LN>({IGNORE_CHAR})                    {BEGIN(INITIAL); return LN;}
<LN><<EOF>>                            {BEGIN(INITIAL); return LN;}
<INITIAL>"LOG"                         {BEGIN(LOG);}
<LOG>[a-zA-Z0-9]+                      {BEGIN(INITIAL); return IDENTIFICADOR;}
<LOG>({SIMBOLOS})                      {BEGIN(INITIAL); unput(yytext[0]); return LOG;}
<LOG>({IGNORE_CHAR})                   {BEGIN(INITIAL); return LOG;}
<LOG><<EOF>>                           {BEGIN(INITIAL); return LOG;}
<INITIAL>"SGN"                         {BEGIN(SGN);}
<SGN>[a-zA-Z0-9]+                      {BEGIN(INITIAL); return IDENTIFICADOR;}
<SGN>({SIMBOLOS})                      {BEGIN(INITIAL); unput(yytext[0]); return SGN;}
<SGN>({IGNORE_CHAR})                   {BEGIN(INITIAL); return SGN;}
<SGN><<EOF>>                           {BEGIN(INITIAL); return SGN;}
<INITIAL>"INT"                         {BEGIN(INT);}
<INT>[a-zA-Z0-9]+                      {BEGIN(INITIAL); return IDENTIFICADOR;}
<INT>({SIMBOLOS})                      {BEGIN(INITIAL); unput(yytext[0]); return INT;}
<INT>({IGNORE_CHAR})                   {BEGIN(INITIAL); return INT;}
<INT><<EOF>>                           {BEGIN(INITIAL); return INT;}
<INITIAL>"FIX"                         {BEGIN(FIX);}
<FIX>[a-zA-Z0-9]+                      {BEGIN(INITIAL); return IDENTIFICADOR;}
<FIX>({SIMBOLOS})                      {BEGIN(INITIAL); unput(yytext[0]); return FIX;}
<FIX>({IGNORE_CHAR})                   {BEGIN(INITIAL); return FIX;}
<FIX><<EOF>>                           {BEGIN(INITIAL); return FIX;}
<INITIAL>"FRAC"                        {BEGIN(FRAC);}
<FRAC>[a-zA-Z0-9]+                     {BEGIN(INITIAL); return IDENTIFICADOR;}
<FRAC>({SIMBOLOS})                     {BEGIN(INITIAL); unput(yytext[0]); return FRAC;}
<FRAC>({IGNORE_CHAR})                  {BEGIN(INITIAL); return FRAC;}
<FRAC><<EOF>>                          {BEGIN(INITIAL); return FRAC;}
<INITIAL>"ROUND"                       {BEGIN(ROUND);}
<ROUND>[a-zA-Z0-9]+                    {BEGIN(INITIAL); return IDENTIFICADOR;}
<ROUND>({SIMBOLOS})                    {BEGIN(INITIAL); unput(yytext[0]); return ROUND;}
<ROUND>({IGNORE_CHAR})                 {BEGIN(INITIAL); return ROUND;}
<ROUND><<EOF>>                         {BEGIN(INITIAL); return ROUND;}
[a-zA-Z][a-zA-Z0-9]*                   {return IDENTIFICADOR;}
[0-9]+(","[0-9]+)?"E"("+"|"-")?[0-9]+  {return EXPONENCIAL;}
[0-9]+","[0-9]+                        {return DECIMAL;}
[0-9]+                                 {return ENTERO;}
({SIMBOLOS})                           {return return_simbolo(yytext[0]);}
({IGNORE_CHAR})                        {}

%%

int return_simbolo(char simbol)
{
    switch(simbol){
        case '+': return O_SUMA;
        case '-': return O_RESTA;
        case '/': return O_DIV;
        case ':': return O_DIVE;
        case '!': return O_FACT;
        case '^': return O_EXP;
        case '|': return O_ABS;
        case '(': return O_PIZQ;
        case ')': return O_PDER;
        case '=': return O_IGUAL;
        default:  return O_ERR;
    };
};