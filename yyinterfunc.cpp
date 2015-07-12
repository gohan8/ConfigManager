#include <iostream>
#include <utility>
#include <sstream>
#include <vector>
#include <stdio.h>
#include "yyinterfunc.h"
#include "cfg.h"

extern "C" {
	extern FILE *yyin;
	extern int yyparse();
	}
cfg data;

using namespace std;

vector<pair<string*,string*>*> tableMembers;


extern "C" void strAtrib(char *id, char *str) {
	string strid = id;
	string strval = str;
	data.put(strid,strval);
	cout << "Atrib of " << str << " to " << id << endl;
}

extern "C" void intAtrib(char *id, int val){
	cout << "Atrib int of " << id << " to " << val << endl;
	string strid = id;
	ostringstream os;
	os << val;
	data.put(strid,os.str());
}
	
extern "C" void tableDecl(char *id){
	cout << "Creating table " << id << endl;
	while(!tableMembers.empty()) {
	    pair<string*,string*>* pp = tableMembers.back();
		ostringstream strid;
		strid << id << '.' << *(pp->first);

		cout << "Popping " << strid.str() << " = " << *(pp->second) << endl;
		data.put(strid.str(), *(pp->second));
		tableMembers.pop_back();
		delete(pp->first); delete(pp->second);
		delete pp;
	}
		
}

extern "C" void pushTableMember(char *id, char *str){
	//All pointers deleted in the call to tableDelc
	string *strid = new string(id);
	string *val = new string(str);
	tableMembers.push_back(new pair<string*,string*>(strid,val));
}
	

int main(int argc, char* argv[])
{
	FILE* input=0;
	if (argc > 0) {
		input = fopen(argv[1],"rb");
		if (!input) {
			printf("Nao foi possivel abrir %s \n", argv[1]);
			return (-1);
		}
		yyin = input;
	}
    yyparse();
    fclose(input);
    
    data.printall();
}

 	
