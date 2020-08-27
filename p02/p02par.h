#ifndef p02par_h
#define p02par_h

#ifndef __cplusplus
extern "C"
#endif

int yyparse(void);
#endif

class Parser : public Lexer{
public:
	Parser(FILE* i):Lexer(i){};
	~Parser();	
	int Parse(void){
	return yyparse();
	}

};

