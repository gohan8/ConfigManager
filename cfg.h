#include <iostream>
#include <sstream>
#include <map>
#include <string>

using namespace std;

class NotNumberException : std::exception{
	string* message;
public:
	NotNumberException(const string& lmsg) : std::exception(), 
		message(new string(lmsg)){
	}
	
	const string& GetMessage() {
		return *message;
	}
	
	virtual const char* what() const throw() {
	    return message->c_str();
	}
	
	virtual ~NotNumberException() throw(){
	    cout << "Exception destructor." << endl;
		if (message) delete message;
	}
};

class cfg {
    typedef std::map<string,string>::iterator ValueIt ;
	std::map<string,string> values;
	const string nokey;
public:
	void put(const string &key, const string &val){values[key] = val;}
	const string& get(const string& key) { 
		if (contains(key)) return values[key];
		else return nokey;
	}
	bool contains(const string& key) {
		ValueIt it = values.find(key);
		return (it != values.end());
	}
	int getIntValue(const string& key) throw() {
		const string& val = get(key);
		int ival;
		try {
			istringstream(val) >> ival;
		}catch(std::exception& e){
		    cout << e.what() << endl;
			throw *(new NotNumberException("Not a valid number."));
		}
	}
	
	void printall(){
		for(ValueIt it = values.begin(); it != values.end(); it++)
			cout << it->first << "\t" << it->second <<endl;
	}
};
	
	
	
