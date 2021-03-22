 %{
  #include <stdlib.h>
  #include <stdio.h>
  #include <string.h>
  #include "userdef.h"

  int yylex(void);
  void yyerror(char *);
  void debug_info(char *, int *, char *);
  void stm_info();

  extern varIndex strMem[256];

  int iMaxIndex=0;
  int iCurIndex=0;
  char sBuff[10][20]={0};
  int iBuffX=0;
  int iBuffY=0;
%}

  %token INT VAR
  %left '+' '-'
  %left '*' '/'

%%

  program:
  program statement
  |
  ;

  statement:
  expr { printf("%d\n",$1); }
  | VAR '=' expr { debug_info("=",yyvsp,"210"); strMem[$1].iValue=$3;  }
  | statement '\n' { printf("--------------------------------\n\n"); }
  ;

  expr:

  INT { debug_info("INT",yyvsp,"0"); $$ = $1;  }
  | VAR { debug_info("VAR",yyvsp,"2"); $$ =  strMem[$1].iValue; }
  | expr '*' expr { debug_info("*",yyvsp,"010"); $$ = $1 * $3; }
  | expr '/' expr { debug_info("/",yyvsp,"010"); $$ = $1 / $3; }
  | expr '+' expr { debug_info("+",yyvsp,"010"); $$ = $1 + $3; }
  | expr '-' expr { debug_info("-",yyvsp,"010"); $$ = $1 - $3; }
  | '(' expr ')'  { debug_info("()",yyvsp,"101"); $$ = $2;     }
  ;

%%

void debug_info(char * info,int * vsp, char * mark) {
    printf("--RULE: %s \n", info);
    int i=0;
    int ilen=strlen(mark);

    for(i=0;i>=1-ilen;i--) {
     switch(mark[ilen+i-1]){
      case '1':
       printf("$%d %d %c \n", i+ilen, vsp[i], vsp[i]);
       break;
      case '0':
       printf("$%d %d \n", i+ilen, vsp[i]);
       break;
      case '2':
       printf("$%d %s %d\n", i+ilen, strMem[vsp[i]].sMark, strMem[vsp[i]].iValue);
       break;
     }
    }
    stm_info();
}

void stm_info() {
   int i=0;
   printf("--STATEMENT: \n");
   /*
   for(i=0;i<=iBuffX;i++)
    printf("%s \n",sBuff[i]);
   */

   if(iBuffY==0)
    printf("%s \n",sBuff[iBuffX-1]);
   else
    printf("%s \n",sBuff[iBuffX]);
  printf("\n");
}

void yyerror(char *s) {
  printf("%s\n", s);
}

int main(void) {
  yyparse();
  return 0;
}