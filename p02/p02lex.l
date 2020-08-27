/*p01lex.l is the lex file scanner for the pascal scanner
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
*/

%{
#include <string>
#include <iostream>
#include <fstream>
#include <iomanip>
#include <cstdio>
#include "p02tkn.h"
#include "p02lex.h"
#include <map>
using namespace std;

extern ofstream opf;
int rowNumber = 1;
int colNumber = 1;
int static length;
int static prevToken = 0;
int static currentToken = 0;
static map<int, string> Token;
static map<string, int> Reserve;

int TokenMgr(int);
void TokenTrace(int t, ostream& o);
void PopulateTokens();
void PopulateReserveNames();

struct NoMatch{
	NoMatch(char p, int l, int c)
	{
	cout << endl;
	cout << "line: " << l << " col: " << c;
	cout << "Character not matched: ";
	cout << "Character: " << p << ", code: " << (int)p;
	cout << endl;
	}
};

%}

%%
"\'"[^']*('')[^']*"\'"			return TokenMgr(CHRLIT);
"\'"[^']+"\'"				return TokenMgr(CHRLIT);
('')+					return TokenMgr(CHRLIT);
"'"					return TokenMgr(APOSTROPHE);
"["					return TokenMgr(LBRACKET);
"]"					return TokenMgr(RBRACKET);		
" "					colNumber+=strlen(yytext);
[\t]+					colNumber+=strlen(yytext);
[\n]					rowNumber++; colNumber = 1;
[0-9]+					return TokenMgr(INTLIT);
[0-9]+\.[0-9]+[E|e][+|-][0-9]+		return TokenMgr(REALINT);
[0-9]+\.[0-9]+				return TokenMgr(REALINT);
[0-9]+[E|e][+|-][0-9]+			return TokenMgr(REALINT);						
[_a-zA-Z][_a-zA-Z0-9]*			return TokenMgr(ID);
"=" 					return TokenMgr(EQU);
"<>"					return TokenMgr(NEQ);
"<"					return TokenMgr(LES);
"<="					return TokenMgr(LEQ);
">"					return TokenMgr(GRT);
">="					return TokenMgr(GEQ);
"+"					return TokenMgr(PLUS);
"-"					return TokenMgr(MINUS);
"*"					return TokenMgr(STAR);
"/"					return TokenMgr(SLASH);
":="					return TokenMgr(ASSIGN);
"("					return TokenMgr(LPAREN);
")"					return TokenMgr(RPAREN);
[{][^}]*				prevToken = LCURLY; /*currentToken = LCURLY; used for printing*/ colNumber+= strlen(yytext);//return TokenMgr(LCURLY);
[}] 					if(prevToken == LCURLY){prevToken = 0; colNumber+=strlen(yytext); /*return TokenMgr(RCURLY);*/} else{return TokenMgr(RCURLY);}	
":"					return TokenMgr(COLON);
";"					return TokenMgr(SEMICOLON);
","					return TokenMgr(COMMA);
"."					return TokenMgr(PERIOD);
".."					return TokenMgr(RANGE);
.					{throw NoMatch(*yytext, rowNumber, colNumber);}					
%%

int TokenMgr(int tokenNum){
	//I enjoy using BFMI and the color yellow
	string spelling = (string)yytext;
	length = spelling.length(); 
	
	for(int i = 0; i < length; i++){
	spelling[i] = tolower(spelling[i]);
	};		
	colNumber += length;

	int tc = tokenNum;
	if(tokenNum == ID){
	tc = Reserve[spelling];
	if(tc == 0) tc = tokenNum;
	}
	TokenTrace(tc, opf);
	return tc;
}

Lexer::Lexer(FILE *i){
	yyin = i;
	PopulateTokens();
	PopulateReserveNames();
}

void PopulateTokens(void){
	Token[AND] = "AND"; 	Token[ARRAY] = "ARRAY";   Token[BEGAN] = "BEGIN";
	Token[DIV] = "DIV"; 	Token[DO] = "DO"; 	  Token[DOWNTO] = "DOWNTO"; 	Token[ELSE] = "ELSE"; 
	Token[END] = "END"; 	Token[FOR] = "FOR"; 	  Token[FUNCTION] = "FUNCTION"; Token[IF] = "IF";
	Token[MOD] = "MOD"; 	Token[NOT] = "NOT"; 	  Token[OF] = "OF"; 		Token[OR] = "OR";
	Token[PROCEDURE] = "PROCEDURE"; 		  Token[PROGRAM] = "PROGRAM"; 	Token[REPEAT] =  "REPEAT"; 
	Token[THEN] = "THEN"; 	Token[TO] = "TO"; 	  Token[UNTIL] = "UNTIL"; 	Token[VAR] = "VAR"; 
	Token[WHILE] = "WHILE"; Token[EQU] = "EQU"; 	  Token[NEQ] = "NEQ"; 		Token[LES] = "LES"; 
	Token[LEQ] = "LEQ"; 	Token[GRT] = "GRT"; 	  Token[GEQ] = "GEQ"; 		Token[PLUS] = "PLUS";
	Token[MINUS] = "MINUS"; Token[STAR] = "STAR"; 	  Token[SLASH] = "SLASH"; 	Token[ASSIGN] = "ASSIGN";
	Token[LPAREN] = "LPAREN";Token[RPAREN] = "RPAREN";Token[LBRACKET] = "LBRACKET";	Token[RBRACKET] = "RBRACKET";
	Token[LCURLY] = "LCURLY";Token[RCURLY] = "RCURLY";Token[COLON] = "COLON";	Token[SEMICOLON] = "SEMICOLON";
	Token[COMMA] = "COMMA";	Token[PERIOD] = "PERIOD"; Token[RANGE] = "RANGE";	Token[APOSTROPHE] = "APOSTROPHE";
	Token[ID] = "ID";	Token[INTLIT] = "INTLIT"; Token[CHRLIT] = "CHRLIT";	Token[REALINT] = "REALINT";
	Token[READ] = "READ";	Token[WRITE] = "WRITE"; 
}

void PopulateReserveNames(void){
	Reserve["and"] = AND;	Reserve["array"] = ARRAY;	Reserve["begin"] = BEGAN;
        Reserve["div"] = DIV;	Reserve["do"] = DO;		Reserve["downto"] = DOWNTO;	
	Reserve["else"] = ELSE;	Reserve["end"] = END;		Reserve["for"] = FOR;		
	Reserve["function"] = FUNCTION;				Reserve["if"] = IF;
        Reserve["mod"] = MOD;	Reserve["not"] = NOT;		Reserve["of"] = OF;		
	Reserve["or"] = OR;	Reserve["procedure"] = PROCEDURE;Reserve["program"] = PROGRAM;	
	Reserve["repeat"] = REPEAT;				Reserve["then"] = THEN;	
	Reserve["to"] = TO;	Reserve["until"] = UNTIL;	Reserve["var"] = VAR;
        Reserve["while"] = WHILE;	Reserve["read"] = READ;	Reserve["write"] = WRITE;
}

int Lexer::Lex(){
	tokenCode = yylex();
	return tokenCode;
}

void TokenTrace(int t, ostream& opf){
	opf << endl;
	opf << "***" << "Code(" << setw(4) << t << ")";
	opf << " ";
	opf << "Name(" << setw(8) << Token[t] << ")";
	opf << " ";
	opf << "Spelling(\"" << setw(7) << yytext << "\")";
	opf << " ";
	opf << "\t" << "Row(" << setw(2) <<rowNumber << "), Col(" << setw(2) << colNumber-length << ")";
}

int Lexer::fetchRowNum(){
	return rowNumber;
}

int Lexer::fetchColNum(){
	return colNumber - length;
}



