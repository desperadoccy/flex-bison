%{

#include "stdio.h"

%}

%%

[\n]                  ;
A                     {printf("ONE\n");}
AA                    {printf("TWO\n");}
AAAAA                  {printf("THREE\n");}

%%