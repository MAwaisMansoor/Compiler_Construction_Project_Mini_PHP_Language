
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ifKeyWord = 258,
     elseKeyWord = 259,
     whileKeyWord = 260,
     echoKeyWord = 261,
     functionKeyWord = 262,
     identifier = 263,
     singleLineComment = 264,
     multiLineComment = 265,
     codeBlockStart = 266,
     codeBlockEnd = 267,
     characterLiteral = 268,
     stringLiteral = 269,
     integerLiteral = 270,
     floatLiteral = 271,
     plusOperator = 272,
     minusOperator = 273,
     multiplyOperator = 274,
     divideOperator = 275,
     squareOperator = 276,
     modulusOperator = 277,
     lessThanOperator = 278,
     greaterThanOperator = 279,
     lessThanEqualToOperator = 280,
     greaterThanEqualToOperator = 281,
     equalEqualToOperator = 282,
     equalToOperator = 283,
     notEqualToOperator = 284,
     curlyBracketOpen = 285,
     curlyBracketClose = 286,
     squareBracketOpen = 287,
     squareBracketClose = 288,
     paranthesisOpen = 289,
     paranthesisClose = 290,
     semicolon = 291,
     comma = 292,
     dot = 293,
     undefinedID = 294
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


