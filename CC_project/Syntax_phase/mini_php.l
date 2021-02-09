%{
   #include"mini_php.tab.h"
%}

del [ \t\n]
let [a-zA-Z_]
digit [-+]?[0-9]
chr '[a-zA-Z0-9]'
str \"([^\"\n])*\"
float [-+]?([0-9]+|[0-9]*\.[0-9]+([eE][-+]?[0-9]+)?)
mul_line_com \/\*([\n\t]|[ ]|[0-9a-zA-Z])*\*\/
single_line_com1 \/\/.*$
single_line_com2 #.*$

%%

[\n]                        {return newLine;} 
{del}+                      {}
[Ii][fF]                    {return ifKeyWord;}
[Ee][Ll][Ss][Ee]            {return elseKeyWord;}
[Ee][Cc][Hh][Oo]            {return echoKeyWord;}
[Ww][Hh][Ii][Ll][Ee]        {return whileKeyWord;}
[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]        {return functionKeyWord;}
"<?"[Pp][Hh][Pp]            {return codeBlockStart;}
"?>"                        {return codeBlockEnd;}
"+"                         {return plusOperator;}
"-"                         {return minusOperator;}
"%"                         {return modulusOperator;}
"*"                         {return multiplyOperator;}
"**"                        {return squareOperator;}
"/"                         {return divideOperator;}
"<"                         {return lessThanOperator;}
">"                         {return greaterThanOperator;}
"<="                        {return lessThanEqualToOperator;}
">="                        {return greaterThanEqualToOperator;}
"=="                        {return equalEqualToOperator;}
"="                         {return equalToOperator;}
"!="                        {return notEqualToOperator;}
"["                         {return squareBracketOpen;}
"]"                         {return squareBracketClose;}
"{"                         {return curlyBracketOpen;}
"}"                         {return curlyBracketClose;}
"("                         {return paranthesisOpen;}
")"                         {return paranthesisClose;}
";"                         {return semicolon;}
","                         {return comma;}
"."                         {return dot;}
{chr}                       {return characterLiteral;}
{str}                       {return stringLiteral;}
({digit})+                  {return integerLiteral;}
"$"({let}|{digit})*         {return identifier;}
({let}|{digit})*            {return identifier;}   
{float}                     {return floatLiteral;}
{single_line_com1}          {return singleLineComment;}
{single_line_com2}          {return singleLineComment;}
{mul_line_com}              {return multiLineComment;}       
.                           {return yytext[0];}

%%

int yywrap(void){
   return 1;
}

