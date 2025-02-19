#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"

extern int yyparse(void);
extern int errlex;
extern int errsint;

typedef void (*compilation_status_handler)(void);

void print_error_summary(void) {
    printf("Errores de compilación\n");
    printf("Errors sintácticos: %d - Errores léxicos: %d\n", errsint, errlex);
}

void print_success(void) {
    printf("Compilación terminada con éxito\n");
    printf("Errors sintácticos: %d - Errores léxicos: %d\n", errsint, errlex);
}

int main(void) {
    int resultado = yyparse();
    compilation_status_handler handlers[] = {print_success, print_error_summary};
    handlers[(errlex > 0 || errsint > 0)]();
    return resultado;
}