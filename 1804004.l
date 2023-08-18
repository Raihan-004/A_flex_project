%option noyywrap

%{
#include <stdio.h>
#include <string.h>
%}

%%
"for"|"if"|"else"|"int"|"char"|"float"|"string"|"main"|"return"|"while"|"break"|"continue" {
    printf("Token: Keyword(%s)\n", yytext);
}

[><=!]=      	      printf("Token: Relational Operator(%s)\n", yytext);

[+\-*/]|[+|-]{2}      printf("Token: Arithmetic Operator(%s)\n", yytext);

[+\-*/]={1}           printf("Token: Assignment Operator(%s)\n", yytext);

"&&"|"||"|"!"         printf("Token: Logical Operator(%s)\n", yytext);

[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?    printf("Token: Valid Number(%s)\n", yytext);

[a-zA-Z_][a-zA-Z_0-9]*\(  { printf("Token: Function Name(%.*s)\n", yyleng - 1, yytext); }

[a-zA-Z_][a-zA-Z0-9_]*   { printf("Token: Valid Identifier(%s)\n", yytext);}

\"[^\"]*\" { printf("Token: String(%s)\n", yytext);}

[(){}[\],;] { printf("Token: Other Symbol(\"%s\")\n", yytext);}

\n          /* Ignore newline */
.           /* Ignore all other characters */
%%

int main() {
    FILE *input_file = fopen("input.txt", "r");
    if (input_file == NULL) {
        perror("Error opening the file");
        return 1;
    }

    printf("Tokenizing input C code:\n");  
    printf("-----------------\n");   
   
    yyin = input_file;

    yylex();

    fclose(input_file);
    return 0;
}
