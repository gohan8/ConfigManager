%{
#include <stdio.h>
#include <stdlib.h>
#include "yyinterfunc.h"

char buffer[16];
char buffer2[16];

%}

%union 
{
        int number;
        char *string;
}

%token <string> ID
%token <number> INT
%token <number> HEXNUMBER
%token <string> STRING


%start optfile

%%

optfile : blocks
        ;
blocks : 
	   | blocks block 			{ printf("blocks\n");}
	   ;
block : atribs 					{ printf("atribs\n");}
      | table
      ;
table : ID '{' tablebody '}' 	{ tableDecl($1); free($1);} //IDvalue token value is alocated by strdup in optlexerl
      ;

tablebody : decl ',' tablebody 
	      | decl				{printf("tablebody\n"); }
	      ;
decl : ID '=' val				{ pushTableMember($1, $<string>3); free($1); free($<string>3); }
	 | ID '=' intval 			{ sprintf(buffer,"%d",$<number>3); pushTableMember($1,buffer);  free($1); }
     | '[' INT ']' '=' val 		{ sprintf(buffer,"%d", $2); pushTableMember(buffer, $<string>5); free($<string>5); } 
     | '[' INT ']' '=' intval 	{ sprintf(buffer,"%d", $2); sprintf(buffer,"%d", $<number>5); pushTableMember(buffer, buffer2); }
     ;     
atribs : atrib ',' atribs 		{ printf("virgula\n"); }
       | atrib
       ;
atrib : ID '=' val 				{ strAtrib($1,$<string>3); free($1); free($<string>3); }
      | ID '=' intval 			{ intAtrib($1,$<number>3); free($1); }
	  | '[' INT ']' '=' val 	{ sprintf(buffer,"%d", $2); strAtrib(buffer, $<string>5); free($<string>5); }
	  | '[' INT ']' '=' intval 	{ sprintf(buffer,"%d", $2); intAtrib(buffer, $<number>5); }
      ;
val : STRING 					{ printf("string: %s",$1); $<string>$ = $1; }
    | ID	 					{ printf("id: %s",$1); $<string>$ = $1; }
    ;
intval: INT 					{ printf("int: %d",$1);  $<number>$ = $1; }
	  | HEXNUMBER				{ printf("hex: %x",$1);  $<number>$ = $1; } 
	  ;

