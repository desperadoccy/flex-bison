%{
  #include <stdlib.h>
  #include <string.h>
  #include "userdef.h"
  #include "example.tab.h"

  void yyerror(char *);
  void add_buff(char *);
  void add_var(char *);

  extern char sBuff[10][20];
  extern int iBuffX;
  extern int iBuffY;
  extern varIndex strMem[256];
  extern int iMaxIndex;
  extern int iCurIndex;

%}

%%

[a-zA-Z][a-zA-Z0-9]*        { add_var(yytext); yylval = iCurIndex; add_buff(yytext);  return VAR; }
[0-9]+       { yylval = atoi(yytext); add_buff(yytext); return INT;  }
[-+()=*/]    { yylval = *yytext; add_buff(yytext); return *yytext; }
[\n]         { yylval = *yytext; iBuffY=0;iBuffX++; return *yytext; }  
[\t]         ;/* 去除空格 */
.            yyerror("无效字符");

%%

void add_buff(char * buff) {
   strcat(sBuff[iBuffX],buff);
   iBuffY+=strlen(buff);
}

void add_var(char *mark) {
  if(iMaxIndex==0){
    strcpy(strMem[0].sMark,mark);
    iMaxIndex++;
    iCurIndex=0;
    return;
}

int i;

for(i=0;i<=iMaxIndex-1;i++) {
    if(strcmp(strMem[i].sMark,mark)==0) {
     iCurIndex=i;
     return;
    }
}

strcpy(strMem[iMaxIndex].sMark,mark);
   iCurIndex=iMaxIndex;
   iMaxIndex++;
}

int yywrap(void) {
  return 1;
}