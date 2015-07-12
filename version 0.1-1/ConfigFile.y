%{
    #include <stdio.h>
    
    void yyerror(const char *msg){
    	fprintf(stderr,"Erro: %s\n",msg);
    }

%}

%start prog
%token ID CONST_INT CONST_STR

%%

prog: prog block
	  |
	  ;

block: table
	   | cmd
	   ;

cmd : '[' CONST_INT ']' '=' rhs
	| ID '=' rhs
	;

rhs: CONST_STR
	| ID
	| CONST_INT
	;
	
table: ID '{' tablebody tableend
	  | ID '{' tableend
	  ;

tableend: '}'
		| ',' '}'

tablebody: cmd
		  | tablebody ',' cmd
	  ;

%%


int main (void) {
	return yyparse ();
}


