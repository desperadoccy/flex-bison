%{

#include <stdlib.h>
#include "lexya_b.tab.h"

void yyerror(char *);
void add_buff(char *);

extern char sBuff[10][20];
extern int iX;
extern int iY;

%}

%%

[a-z]        { yylval = *yytext; add_buff(yytext);  return VAR; }
[0-9]+       { yylval = atoi(yytext); add_buff(yytext); return INT;  }
[-+()=*/]    { yylval = *yytext; add_buff(yytext); return *yytext; }
[\n]         { yylval = *yytext; iY=0;iX++; return *yytext; }  
[\t]         ;/* 去除空格 */
.            yyerror("无效字符");

%%

void add_buff(char * buff) {
    sBuff[iX][iY]=*buff; iY++;
}

int yywrap(void) {
    return 1;
}

 