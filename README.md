# ConfigManager
A service to read a config file with a specified grammar.

OptGrammarFile.y -> Grammar File that specify the config file format

optlexer.l -> lexer file

yacc is used to parse the config file. Than an dictionary is created with name/value pairs as given in the config file.
