%{
#include <stdlib.h>
void yyerror(char *);
#include "calculate.tab.h"
%}

%%

[0-9]+          { yylval = atoi(yytext); return INTEGER; }
[-+*/\n]        return *yytext;
[\t]            ;/* 去除空格 */
.               yyerror("无效字符");

%%

int yywrap(void) {
  return 1;
}