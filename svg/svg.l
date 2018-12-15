unicode unicode=
glyphname glyph-name=
path d=
value \"([^\"])+\" 
tag <glyph
%{
    #include "string.h"
    #include "stdlib.h"
    #define YYSTYPE char*
    #include "svg.parser.h"
%}
%option outfile="svg.lex.c"
%option header-file="svg.lex.h"
%%
{value} {
    char * p = (char *) malloc(strlen(yytext));
    memset(p, 0, strlen(yytext));
    strcpy(p, yytext);
    yylval = p;
    // printf("yytext = %s\n", yytext);
    return VALUE; 
}
{unicode} {
    return UNICODE;
}
{glyphname} {
    return GLYPHNAME;
}
{path} {
    return PATH;
}
{tag} {
    return TAG;
}
[ \t]   ;   /*skip whitespace*/
.       ; /* skip */

%%

int yywrap(void) {
    return 1;
}