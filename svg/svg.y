%token UNICODE
%token GLYPHNAME
%token PATH
%token VALUE
%token TAG
%token OTHER
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <ctype.h>
    #include <stdbool.h>
    #define YYSTYPE char*
    #define jsFuntion "var normalViewBox='0 0 1024 1024';var newViewBox='64 64 896 896';var fill='fill';var outline='outline';var twotone='twotone';function getNode(viewBox){var paths=[];for(var _i=1;_i<arguments.length;_i++){paths[_i-1]=arguments[_i]}return{tag:'svg',attrs:{viewBox:viewBox},children:paths.map(function(path){if(Array.isArray(path)){return{tag:'path',attrs:{fill:path[0],d:path[1]}}}return{tag:'path',attrs:{d:path}}})}}function getIcon(name,theme,icon){return{name:name,theme:theme,icon:icon}}\n"
    #define templateStr "exports[%s] = getIcon(%s, fill, getNode(newViewBox, %s));\n"
    #define zoomPrefix "\"zoom-"
    extern FILE * yyin;
    int svgnums = 0;
    char svg_name[1000], svg_path[100000];
    FILE * fp;

    void tansformName(char * dest, char * src);
    void strToLower(char * str);
%}

%%
 /*must start with program*/
program: program svg | svg {printf("dede");};
svg: code name path {
    svgnums++;
    char svg_key_name[1000];
    tansformName(svg_key_name, svg_name);
    fprintf(fp, templateStr, svg_key_name, svg_name, svg_path);
}
    | code path {svgnums++;}
    ;
code: TAG UNICODE VALUE {};
name: GLYPHNAME VALUE {
    memset(svg_name, 0, sizeof(svg_name));
    strcat(svg_name, zoomPrefix);
    strcat(svg_name, $2 + 1);
    strToLower(svg_name);
    printf("svg_name = %s\n", svg_name);
};
path: PATH VALUE {
    strcpy(svg_path, $2);
    // svg_path = $2;
};
%%

int yyerror(char * s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main(void) {
    printf("zoomprefix: %s\n", zoomPrefix);
    yyin = fopen("./test", "r");
    fp = fopen("./zoomicon.js", "w");
    if (fp == NULL || yyin == NULL) exit(1);
    fwrite(jsFuntion, 1, strlen(jsFuntion), fp);
    yyparse();
    printf("svgnums = %d\n", svgnums);
    fclose(yyin);
    fclose(fp);
    return 0;
}

void tansformName(char * dest, char * src) {
    memset(dest, 0, 1000);
    dest[0] = '\"';
    dest[1] = 'Z';
    int l = (int) strlen(src);
    int j = 2;
    bool isNextUpper = false;

    for (int i = 2; i < l; i++) {
        if (src[i] == '-' || src[i] == '\"') {
            isNextUpper = true;
            continue;
        }

        if (isNextUpper) {
            dest[j] = toupper(src[i]);
            isNextUpper = false;
        } else {
            dest[j] = src[i];
        }
        j++;
    }

    strcat(dest, "Fill\"");
}

void strToLower(char * str) {
    int l = (int) strlen(str);
    for (int i = 0; i < l; i++) {
        str[i] = tolower(str[i]);
    }
}