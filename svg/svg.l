unicode unicode=
glyphname glyph-name=
path d=
value \"([^\"])*\" 
glyphtag <glyph
xmlstart <\?xml
xmlend \?>
key [-A-Za-z]+=
doctyleStart <\!DOCTYPE
tag <[a-z-]+
end <\/[a-z-]+>
selfend \/>
svgrootstart <svg
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
    printf("value = %s\n", yytext);
    char * p = (char *) malloc(strlen(yytext));
    memset(p, 0, strlen(yytext));
    strcpy(p, yytext);
    yylval = p;
    return VALUE; 
}

{xmlstart} {
    return XMLSTART;
}
{xmlend} {
    return XMLEND;
}
    /*extract glyph info*/
{glyphtag} {
    printf("glyphtag\n");
    return GLYPHTAG;
}
{glyphname} {
    return GLYPHNAME;
}
{path} {
    printf("path\n");
    return PATH;
}
{key} {
    printf("key = %s\n", yytext);
    return KEY;
}
{doctyleStart} {
    return DOCTYPESTART;
}
{svgrootstart} {
    return SVGROOTSTART;
}
{tag} {
    return TAG;
}

{end} {
    return END;
}

{selfend} {
    return SELFEND;
}

> {
    return '>';
}

[ \t]   ;   /*skip whitespace*/
.       ; /* skip */

%%

int yywrap(void) {
    return 1;
}