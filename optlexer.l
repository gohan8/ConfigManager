%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

int hval = 0;
%}

%%

[0-9]+ 					{yylval.number = atoi(yytext); return INT;}
0x[0-9ABCDEF]+			{sscanf(yytext,"0x%x",&hval); yylval.number = hval;  return HEXNUMBER;}
[a-zA-Z0-9_]+			{yylval.string = strdup(yytext); return ID;}
,						{ return ','; }
;						{ return ';'; }
=						{ return '='; }
\{						{ return '{'; }
\}						{ return '}'; }
\]						{ return ']'; }
\[						{ return '['; }
\"[^\"]*\"				{yylval.string = strdup(yytext);  return STRING;}
'.*'					{yylval.string = strdup(yytext);  return STRING;}

%%


void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
} 
