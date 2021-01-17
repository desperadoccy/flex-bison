%{

#include "stdio.h"

int linenum;

%}

int                   [0-9]+

float                 [0-9]*\.[0-9]+

%%

{int}                 printf("Int     : %s\n",yytext);

{float}               printf("Float   : %s\n",yytext);

.                     printf("Unknown : %c\n",yytext[0]);

%%