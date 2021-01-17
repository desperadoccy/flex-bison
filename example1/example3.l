%{

#include "stdio.h"

%}

%%

[\n]                  ;
A                     {printf("ONE\n");}
AA                    {printf("TWO\n");}
AAAA                  {printf("THREE\n");}
AAAA                  {printf("Cannot be executed!");}

%%
