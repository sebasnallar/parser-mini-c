%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex(void);
extern FILE* yyin;
extern int line_number;
void yyerror(const char *s);
int errlex = 0;
int errsint = 0;
%}

%union {
    char *elemento;
    char letra;
}

%token INICIO_BLOQUE FIN_BLOQUE
%token INICIO_CADENA FIN_CADENA
%token <elemento> ELEMENTO
%token <letra> LETRA
%token OP_HASH OP_PERCENT OP_QUESTION OP_AT

%right OP_AT
%left OP_PERCENT OP_QUESTION
%right OP_HASH

%%

programa: bloques                 
        ;

bloques: bloque
       | bloques bloque
       ;

bloque: INICIO_BLOQUE 
        { printf("[\n"); }
        contenido 
        FIN_BLOQUE
        { printf("]\n"); }
      ;

contenido: /* vacío */
         | contenido item
         ;

item: cadena
    | secuencia { printf("\n"); }
    ;

cadena: INICIO_CADENA 
        { printf("{\n"); }
        elementos 
        FIN_CADENA
        { printf("}\n"); }
      ;

elementos: ELEMENTO
          { printf("%s\n", $1); free($1); }
        | elementos ELEMENTO
          { printf("%s\n", $2); free($2); }
        ;

secuencia: expresion
         ;

expresion: LETRA                          { printf("%c ", $1); }
         | expresion OP_HASH expresion    { printf("# "); }
         | expresion OP_PERCENT expresion { printf("%% "); }
         | expresion OP_QUESTION expresion{ printf("? "); }
         | expresion OP_AT expresion     { printf("@ "); }
         ;

%%

void yyerror(const char *s) {
    if (strstr(s, "Error léxico") != NULL) {
        errlex++;
        printf("línea #%d: %s\n", line_number, s);
    } else {
        errsint++;
        printf("línea #%d: syntax error, unexpected '{', expecting ELEMENTO or '}'\n", line_number);
    }
}