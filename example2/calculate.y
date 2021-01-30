 %{
#include <stdlib.h>
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token INTEGER
%left '+' '-'
%left '*' '/'

%%

program:
  program expr '\n' { printf("%d\n", $2); }
  |
  ;

expr:
  INTEGER { $$ = $1; }
  | expr '*' expr { $$ = $1 * $3; }
  | expr '/' expr { $$ = $1 / $3; }
  | expr '+' expr { $$ = $1 + $3; }
  | expr '-' expr { $$ = $1 - $3; }
  ;

%%

void yyerror(char *s) {
  printf("%s\n", s);
}

int main(void) {
  yyparse();
  return 0;
}