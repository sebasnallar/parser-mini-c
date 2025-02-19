#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"

extern int yyparse(void);
extern int errlex;
extern int errsint;

typedef void (*error_handler)(void);

void print_error_summary(void) {
    printf("Errores de compilación\n");
    printf("Errors sintácticos: %d - Errores léxicos: %d\n", errsint, errlex);
}

void do_nothing(void) {}

int main(void) {
    int resultado = yyparse();
    error_handler handlers[] = {do_nothing, print_error_summary};
    handlers[(errlex > 0 || errsint > 0)]();
    return resultado;
}