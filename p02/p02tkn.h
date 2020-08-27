/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    AND = 258,
    ARRAY = 259,
    BEGAN = 260,
    DIV = 261,
    DO = 262,
    DOWNTO = 263,
    ELSE = 264,
    END = 265,
    FOR = 266,
    FUNCTION = 267,
    IF = 268,
    MOD = 269,
    NOT = 270,
    OF = 271,
    OR = 272,
    PROCEDURE = 273,
    PROGRAM = 274,
    REPEAT = 275,
    THEN = 276,
    TO = 277,
    UNTIL = 278,
    VAR = 279,
    WHILE = 280,
    EQU = 281,
    NEQ = 282,
    LES = 283,
    LEQ = 284,
    GRT = 285,
    GEQ = 286,
    PLUS = 287,
    MINUS = 288,
    STAR = 289,
    SLASH = 290,
    ASSIGN = 291,
    LPAREN = 292,
    RPAREN = 293,
    LBRACKET = 294,
    RBRACKET = 295,
    LCURLY = 296,
    RCURLY = 297,
    COLON = 298,
    SEMICOLON = 299,
    COMMA = 300,
    PERIOD = 301,
    RANGE = 302,
    APOSTROPHE = 303,
    ID = 304,
    INTLIT = 305,
    CHRLIT = 306,
    REALINT = 307,
    READ = 308,
    WRITE = 309
  };
#endif
/* Tokens.  */
#define AND 258
#define ARRAY 259
#define BEGAN 260
#define DIV 261
#define DO 262
#define DOWNTO 263
#define ELSE 264
#define END 265
#define FOR 266
#define FUNCTION 267
#define IF 268
#define MOD 269
#define NOT 270
#define OF 271
#define OR 272
#define PROCEDURE 273
#define PROGRAM 274
#define REPEAT 275
#define THEN 276
#define TO 277
#define UNTIL 278
#define VAR 279
#define WHILE 280
#define EQU 281
#define NEQ 282
#define LES 283
#define LEQ 284
#define GRT 285
#define GEQ 286
#define PLUS 287
#define MINUS 288
#define STAR 289
#define SLASH 290
#define ASSIGN 291
#define LPAREN 292
#define RPAREN 293
#define LBRACKET 294
#define RBRACKET 295
#define LCURLY 296
#define RCURLY 297
#define COLON 298
#define SEMICOLON 299
#define COMMA 300
#define PERIOD 301
#define RANGE 302
#define APOSTROPHE 303
#define ID 304
#define INTLIT 305
#define CHRLIT 306
#define REALINT 307
#define READ 308
#define WRITE 309

/* Value type.  */

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
#define YYSTYPE_IS_TRIVIAL 1
#define yystype YYSTYPE
#define YYSTYPE_IS_DECLARED 1
#endif
extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
