%{
    #include "./parser.h"
%}
%%
    /* yylval is for yacc to store the match value in its stack the type of yylval is determined by YYSTYPE */
    /* yytext is the match text */
[0-9]+  { yylval = atoi(yytext); return INTEGER; }
    /* yylex is return number and 0~255 is reserved for character in lex */
[-+\n]  return *yytext;
[ \t]   ;   /*skip whitespace*/
.       yyerror("invalid character");
%%

int yywrap(void) {
    return 1;
}