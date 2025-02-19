#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"

extern FILE* yyin;
extern int yyparse(void);
extern int line_number;
extern int errlex;
extern int errsint;

int main(void) {
    int resultado = yyparse();
    if (errlex > 0 || errsint > 0) {
        printf("Errores de compilación\n");
        printf("Errors sintácticos: %d - Errores léxicos: %d\n", errsint, errlex);
    }
    return resultado;
}
