%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int yylex(void);
void yyerror(char *);
void debuginfo(char *, int *, char *);
void printinfo();

int sMem[256];
char sBuff[10][20]={0};
int iX=0;
int iY=0;
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

| VAR '=' expr { debuginfo("=",yyvsp,"110"); sMem[$1]=$3;  }

| statement '\n' { printf("--------------------------------\n\n"); }

;

expr:

INT { debuginfo("INT",yyvsp,"0"); $$ = $1;  }
| VAR { debuginfo("VAR",yyvsp,"1"); $$ = sMem[$1]; }
| expr '*' expr { debuginfo("*",yyvsp,"010"); $$ = $1 * $3; }
| expr '/' expr { debuginfo("/",yyvsp,"010"); $$ = $1 / $3; }
| expr '+' expr { debuginfo("+",yyvsp,"010"); $$ = $1 + $3; }
| expr '-' expr { debuginfo("-",yyvsp,"010"); $$ = $1 - $3; }
| '(' expr ')'  { debuginfo("()",yyvsp,"101"); $$ = $2;     }
;

%%

void debuginfo(char * info,int * vsp, char * mark) {
 /* */
  printf("--RULE: %s \n", info);
  int i=0;
  int ilen=strlen(mark);
  for(i=0;i>=1-ilen;i--) {
   if(mark[ilen+i-1]=='1')
     printf("$%d %d %c \n", i+ilen, vsp[i], vsp[i]);
   else
    printf("$%d %d \n", i+ilen, vsp[i]);
  }
  printinfo();
}

void printinfo() {
 int i=0;
 printf("--STATEMENT: \n");
 if(iY==0)
  printf("%s \n",sBuff[iX-1]);
 else
  printf("%s \n",sBuff[iX]);
 printf("\n");
}

void yyerror(char *s) {
  printf("%s\n", s);
}

int main(void) {
  yyparse();
  return 0;
}