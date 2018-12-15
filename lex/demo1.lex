%% 
    /*anything not start in colomn ont will be copied to c file*/
    /*match everything except newline*/
. ECHO;
    /*match new line*/
\n ECHO;
%%

int yywrap(void) {
    return 1;
}

int main(void) {
    yylex();
    return 0;
}

