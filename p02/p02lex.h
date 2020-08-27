//p01lex.h is the lex file header for the pascal scanner
//----------------------------------------------------------------------
//Author: 1: Chase Minden
//Student ID: *20469963
//E-mail: caminden@uco.edu
//Author: 2: Tommie Walker
//Student ID: *20422860
//E-mail: twalker38@uco.edu
//Course : CMSC 4023 - Programming Languages
//CRN : 21950
//Project: P01
//Due Date: Febuary 26, 2020
//Project Account number: tt068
//---------------------------------------------------------------------


#ifndef p02lex_h
#define p02lex_h 1
//start p01lex.h file

#include <fstream>
#include <cstdio>
#include <iostream>
#include "p02tkn.h"
using namespace std;

#ifndef __cplusplus
extern "C"
#endif
int yylex();

class Lexer{
private:
	int tokenCode;
public:
	Lexer(FILE* i);
	int Lex(void);
	int fetchColNum();
	int fetchRowNum();

};
#endif
