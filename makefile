OBJ_DIR=obj

optparser: 	${OBJ_DIR}/yyinterfunc.o ${OBJ_DIR}/y.tab.o ${OBJ_DIR}/lex.yy.o
	g++ -g ${OBJ_DIR}/yyinterfunc.o ${OBJ_DIR}/y.tab.o ${OBJ_DIR}/lex.yy.o -o optparser

${OBJ_DIR}/lex.yy.o: lex.yy.c y.tab.h
	gcc -c -g lex.yy.c -o ${OBJ_DIR}/lex.yy.o

${OBJ_DIR}/y.tab.o: y.tab.c y.tab.h 
	gcc -c -g y.tab.c -o ${OBJ_DIR}/y.tab.o

${OBJ_DIR}/yyinterfunc.o: yyinterfunc.cpp yyinterfunc.h cfg.h
	g++ -c -g yyinterfunc.cpp -o ${OBJ_DIR}/yyinterfunc.o

y.tab.c y.tab.h: OptFileGrammar.y yyinterfunc.h
	yacc -d OptFileGrammar.y

lex.yy.c: optlexer.l
	lex optlexer.l



