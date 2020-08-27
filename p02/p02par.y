%{
#include <iostream>
#include <fstream>
#include <string>
#include <cstdio>
#include <cmath>
#include <iomanip>
#include <cstdlib>
#include <cstring>
#include "p02lex.h"
#include "p02par.h"
using namespace std;

extern ofstream opf;
extern int rowNumber;
extern int colNumber;
void yyerror(const char*);
%}


%token <token> AND
%token <token> ARRAY
%token <token> BEGAN
%token <token> DIV
%token <token> DO
%token <token> DOWNTO
%token <token> ELSE
%token <token> END
%token <token> FOR
%token <token> FUNCTION
%token <token> IF
%token <token> MOD
%token <token> NOT
%token <token> OF
%token <token> OR
%token <token> PROCEDURE
%token <token> PROGRAM
%token <token> REPEAT
%token <token> THEN
%token <token> TO
%token <token> UNTIL
%token <token> VAR
%token <token> WHILE
%token <token> EQU
%token <token> NEQ
%token <token> LES
%token <token> LEQ
%token <token> GRT
%token <token> GEQ
%token <token> PLUS
%token <token> MINUS
%token <token> STAR
%token <token> SLASH
%token <token> ASSIGN
%token <token> LPAREN
%token <token> RPAREN
%token <token> LBRACKET
%token <token> RBRACKET
%token <token> LCURLY
%token <token> RCURLY
%token <token> COLON
%token <token> SEMICOLON
%token <token> COMMA
%token <token> PERIOD
%token <token> RANGE
%token <token> APOSTROPHE
%token <token> ID
%token <token> INTLIT
%token <token> CHRLIT
%token <token> REALINT
%token <token> READ
%token <token> WRITE

%%

program:
	program_head program_declaration program_body
	{opf << endl << "#001 program -> program_head program_declaration program_body";}

program_head:
	PROGRAM ID program_parameters SEMICOLON
	{opf << endl << "#002 program_head -> PROGRAM ID program_parameters ;";}

program_declaration:
	declarations subprogram_declarations
	{opf << endl << "#003 program_declaration -> declarations subprogram_declarations";}

program_body:
	compound_statement PERIOD
	{opf << endl << "#004 program_body -> compound_statement .";}


program_parameters:
	/* empty */ 
	 {opf << endl << "#005 program_parameters -> empty_string";}
	|LPAREN program_parameter_list RPAREN
	 {opf << endl << "#006 prgram_parameters -> ( program_parameter_list )";}


program_parameter_list:
	identifier_list
	 {opf << endl << "#007 program_parameter_list -> indentifier_list";}


identifier_list:
	ID
	 {opf << endl << "#008 identifier_list -> ID";}
	|identifier_list COMMA ID
	 {opf << endl << "#009 identifier_list -> identifier_list , ID";}


declarations:
	/*empty */
	 {opf << endl << "#010 declarations -> empty_string";}
	|declarations VAR identifier_list COLON type SEMICOLON
	 {opf << endl << "#011 declarations -> declarations VAR identifier_list : type ;";}


type:
	standard_type
	 {opf << endl << "#012 type -> standard_type";}
	|ARRAY LBRACKET intlit_in_array RBRACKET OF standard_type
	 {opf << endl << "#013 type ->ARRAY [INTLIT...INTLIT] OF standard_type";}

intlit_in_array:
	intlit_in_array INTLIT
	| INTLIT
	;

standard_type:
	ID
	{opf << endl << "#014 standard_type -> ID";}

subprogram_declarations:
	/*empty*/ 
	 {opf << endl << "#015 subprogram_declarations -> empty_string";}
	| subprogram_declarations subprogram_declarations SEMICOLON
	 {opf << endl << "#016 subprogram_declarations -> subprogram_declarations subprogram_declarations ;";}
	| subprogram_head declarations compound_statement
	 {opf << endl << "#017 subprogram_declarations -> subprogram_head declarations compound_statement";} 

subprogram_head:
	FUNCTION ID subprogram_parameters COLON standard_type SEMICOLON
	 {opf << endl << "#018 subprogram_head -> FUNCTION ID subprogram_parameters : standard_type ;";}
	| PROCEDURE ID subprogram_parameters
	 {opf << endl << "#019 subprogram_head -> PROCECURE ID subprogram_parameters";}

subprogram_parameters:
	/*empty*/
	 {opf << endl << "#020 subprogram_parameters -> empty_string";}
	| LPAREN parameter_list RPAREN
	 {opf << endl << "#021 subprogram_parameters -> ( parameter_list )";}

parameter_list:
	identifier_list COLON type
	 {opf << endl << "#022 parameter_list -> identifier_list : type";}
	|parameter_list SEMICOLON identifier_list COLON type
	 {opf << endl << "#023 parameter_list ; identifier_list : type";}

compound_statement:
	BEGAN optional_statement END
	 {opf << endl << "#024 compound_statement -> BEGIN optional_statements END";}

optional_statement:
	/*empty */
	 {opf << endl << "#025 optional_statement -> empty_string";}
	| statement_list
	 {opf << endl << "#026 optional_statement -> statement_list";}

statement_list:
	statement
	 {opf << endl << "#027 statement_list -> statement";}
	|statement_list statement
	 {opf << endl << "#028 statement_list -> statement_list statement";}

statement:
	variable ASSIGN expression
	 {opf << endl << "#029 statement -> variable := expression";}
	|procedure_statement
	 {opf << endl << "#030 statement -> procedure_statement";}
	|alternative_statement
	 {opf << endl << "#031 statement -> alternative_statement";}
	|iterative_statement
	 {opf << endl << "#032 statement -> iterative_statement";}
	|compound_statement
	 {opf << endl << "#033 statement -> compound_statement";}

alternative_statement:
	if_statement
	 {opf << endl << "#034 alternative_statement -> if_statement";}
	
iterative_statement:
	while_statement
	 {opf << endl << "#035 iterative_statement -> while_statement";}
	|repeat_statement
	 {opf << endl << "#036 iterative_statement -> repeat_statement";}
	|for_statement
	 {opf << endl << "#037 iterative_statement -> for_statement";}

if_statement:
	IF expression THEN statement ELSE statement
	 {opf << endl << "#038 IF expression THEN statement ELSE statement";}

while_statement:
	WHILE expression DO statement
	 {opf << endl << "#039 WHILE expression DO statement";}

repeat_statement:
	REPEAT statement_list UNTIL expression
	{opf << endl << "#040 REPEAT statement_list UNTIL expression";}

for_statement:
	FOR variable ASSIGN expression TO expression DO statement
	 {opf << endl << "#041 FOR variable := expression TO expression DO statement";}
	|FOR variable ASSIGN expression DOWNTO expression DO statement
	 {opf << endl << "#042 FOR variable := expression DOWNTO expression DO statement";}

variable:
	ID
	 {opf << endl << "#043 variable -> ID";}
	|ID LBRACKET expression RBRACKET
	 {opf << endl << "#044 variable -> ID [expression]";}

procedure_statement:
	ID
	 {opf << endl << "#045 procedure_statement -> ID";}
	|ID LPAREN expression_list RPAREN
	 {opf << endl << "#046 procedure_statement -> ID (expression_list}";}

expression_list:
	expression
	 {opf << endl << "#047 expression_list -> expression";}
	|expression_list expression
	 {opf << endl << "#048 expresssion_list -> expression_list expression";}

expression:
	simple_expression
	 {opf << endl << "#049 expression -> simple_expression";}
	|simple_expression relop simple_expression
	 {opf << endl << "#050 expression -> simple_expression relop simple_epression";}

relop:
	EQU {opf << endl << "#051 relop -> =";}
	|NEQ {opf << endl << "#052 relop -> <>";}
	|LES {opf << endl << "#053 relop -> <";}
	|LEQ {opf << endl << "#054 relop -> <=";}
	|GRT {opf << endl << "#055 relop -> >";}
	|GEQ {opf << endl << "#056 relop -> >=";}

simple_expression:
	term {opf << endl << "#057 simple_expression -> term";}
	|sign term {opf << endl << "#058 simple_expression -> sign term";}
	|simple_expression addop term
	 {opf << endl << "#061 simple_expression -> simple_expression addop term";}

sign:
	PLUS {opf << endl << "#059 sign -> +";}
	|MINUS {opf << endl << "#060 sign -> -";}

addop:
	PLUS {opf << endl << "#062 addop -> +";}
	|MINUS {opf << endl << "#063 addop -> -";}
	|OR {opf << endl << "#064 addop -> OR";}

term:
	factor {opf << endl << "#065 term -> factor";}
	|term mulop factor
	{opf << endl << "#066 term -> term mulop factor"; /*execute order 66*/}

mulop:
	STAR {opf << endl << "#067 mulop -> *";}
	|SLASH {opf << endl << "#068 mulop -> /";}
	|DIV {opf << endl << "#069 mulop -> DIV"; /*nice*/}
	|MOD {opf << endl << "#070 mulop -> MOD";}
	|AND {opf << endl << "#071 mulop -> AND";}

factor:
	ID {opf << endl << "#072 factor -> ID";}
	|ID LBRACKET expression_list RBRACKET
	 {opf << endl << "#073 factor -> ID [ expression_list ]";}
	|ID LCURLY expression_list RCURLY
	 {opf << endl << "#074 factor -> ID ( expression_list )";}
	|LCURLY expression_list RCURLY
	 {opf << endl << "#075 factor -> ( expression_list )";}
	|NOT factor {opf << endl << "#076 factor -> NOT factor";}
	|INTLIT {opf << endl << "#077 factor -> INTLIT";}
	|REALINT {opf << endl << "#078 factor -> REALINT";}
	|CHRLIT {opf << endl << "#079 factor -> CHRLIT";}
	 
%%

struct Error{
	Error(const char* m)
	{	
	cout << endl << "line(" << rowNumber << ") col(" << colNumber << ")" << m;
	cout << endl;
	}
};

void yyerror(const char* m){throw Error(m);}


Parser::~Parser(){}
