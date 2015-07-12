%{

#include <stdio.h>
#include <string.h>
#include "y.tab.h"
#ifndef YYSTYPE
typedef int YYSTYPE;
#endif
extern YYSTYPE yylval;

char ter=0;
char buffer[255];
short len = 0;

%}
%x STRING

white		[ \t\n]+
digit		[0-9]
integer		[-+]?[0-9]+
letter		[A-Za-z]
id		[{letter}_][-_{letter}{digit}]*


%%

[A-Za-z_][-_A-Za-z]*	{ printf("id: %s \n",yytext); return ID;}
[\"']			{BEGIN STRING; ter=yytext[0];}
<STRING>\\n 	{ buffer[len++] = '\n'; buffer[len] = 0;}
<STRING>\\t		{ buffer[len++] = '\t'; buffer[len] = 0; }
<STRING>\\\"	{ buffer[len++] = '"';  buffer[len] = 0; }
<STRING>\\'		{ buffer[len++] = '\''; buffer[len] = 0; }
<STRING>[\"']	{  
				  if (ter==*yytext) {
                    BEGIN 0;
				    
				    len = 0;
				    printf("str: %s \n",buffer);
				    return CONST_STR;
				  }
	              else {
	                buffer[len++] = *yytext;
	                buffer[len] = 0;
	              }
				}
<STRING>.		{strcpy(buffer+len, yytext); len += yyleng;}
<STRING>\n		{printf("String não finalizada.\n"); exit(1); }
{white}		; /* ignore */ 

{integer}	{ yylval = atoi(yytext); return CONST_INT; }
.               return (int) yytext[0];
%%

int yywrap(void) {
    return 1;
}

