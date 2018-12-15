newline ^(.*)\n
%{
    int linenum = 0;
%}
%%
.
{newline} linenum++;
%%

int yywrap(void) {
    return 1;
}

int main(int argc, char ** argv) {
    yyin = fopen(argv[1], "r");
    yylex();
    printf("linenum = %d\n", linenum);
}