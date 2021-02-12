%{
   #include"mini_php.tab.h"
   int j = 0;
   void putLexeme();
   void putIdentifier();
   FILE *idout;
%}


let [a-zA-Z_]
digit [-+]?[0-9]
chr '[a-zA-Z0-9]'
str \"([^\"\n])*\"
float [-+]?([0-9]+|[0-9]*\.[0-9]+([eE][-+]?[0-9]+)?)
mul_line_com \/\*([\n\t]|[ ]|[0-9a-zA-Z])*\*\/
single_line_com1 \/\/.*$
single_line_com2 #.*$

%%
[ ] {
   fprintf(yyout, "< DELIMETER, SPACE >\n");
}

[\n] {
   fprintf(yyout, "< DELIMETER, NEWLINE >\n");
}

[\t] { 
   fprintf(yyout, "< DELIMETER, TAB >\n", yytext);
}

[Ii][fF] {
   fprintf(yyout, "< KEYWORD, ");
   putLexeme();
   return ifKeyWord;
}

[Ee][Ll][Ss][Ee] {
   fprintf(yyout, "< KEYWORD, ");
   putLexeme();
   return elseKeyWord;
}

[Ee][Cc][Hh][Oo] {
   fprintf(yyout, "< KEYWORD, ");
   putLexeme();
   return echoKeyWord;
}

[Ww][Hh][Ii][Ll][Ee] {
   fprintf(yyout, "< KEYWORD, ");
   putLexeme();
   return whileKeyWord;
}

[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn] {
   fprintf(yyout, "< KEYWORD, ");
   putLexeme();
   return functionKeyWord;
}

"<?"[Pp][Hh][Pp] {
   fprintf(yyout, "< CODEBLOCKSTART, ");
   putLexeme();    
   return codeBlockStart;
}

"?>" {
   fprintf(yyout, "< CODEBLOCKEND, ");
   putLexeme();
   return codeBlockEnd;
}

"+" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return plusOperator;
}

"-" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return minusOperator;
}

"%" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return modulusOperator;
}

"*" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return multiplyOperator;
}

"**" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return squareOperator;
}

"/" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return divideOperator;
}

"<" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return lessThanOperator;
}

">" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return greaterThanOperator;
}

"<=" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return lessThanEqualToOperator;
}

">=" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return greaterThanEqualToOperator;
}

"==" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return equalEqualToOperator;
}

"=" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return equalToOperator;
}

"!=" {
   fprintf(yyout, "< OPERATOR, ");
   putLexeme();
   return notEqualToOperator;
}

"[" {
   fprintf(yyout, "< PUNCTUATION, ");
   putLexeme();
   return squareBracketOpen;
}

"]" {
   fprintf(yyout, "< PUNCTUATION, ");
   putLexeme();
   return squareBracketClose;
}

"{" {
   fprintf(yyout, "< PUNCTUATION, ");
   putLexeme();
   return curlyBracketOpen;
}

"}" {
   fprintf(yyout, "< PUNCTUATION, ");
   putLexeme();
   return curlyBracketClose;
}

"(" {
   fprintf(yyout, "< PUNCTUATION, ");
   putLexeme();
   return paranthesisOpen;
}

")" {
   fprintf(yyout, "< PUNCTUATION, ");
   putLexeme();
   return paranthesisClose;
}

";" {
   fprintf(yyout, "< PUNCTUATION, ");
   putLexeme();
   return semicolon;
}

"," {
   fprintf(yyout, "< PUNCTUATION, ");
   putLexeme();
   return comma;
}

"." {
   fprintf(yyout,"< PUNCTUATION, ");
   putLexeme();
   return dot;
}

{chr} {
   fprintf(yyout, "< CHARACTERLITERAL, ");
   putLexeme();
   return characterLiteral;
}

{str} {
   fprintf(yyout, "< STRINGLITERAL, ");
   putLexeme();
   return stringLiteral;
}

({digit})+ {
   fprintf(yyout, "< INTEGERLITERAL, ");
   putLexeme();
   return integerLiteral;
}

"$"({let}|{digit})* {
   fprintf(yyout, "< IDENTIFIER, ");
   fprintf(idout, "< IDENTIFIER, ");
   putLexeme();
   putIdentifier();
   return identifier;
}

({let}|{digit})* {
   fprintf(yyout, "< IDENTIFIER, ");
   fprintf(idout, "< IDENTIFIER, ");
   putLexeme();
   putIdentifier();
   return identifier;
}   

{float} {
   fprintf(yyout, "< FLOATLITERAL, ");
   putLexeme();
   return floatLiteral;
}

{single_line_com1} {
   fprintf(yyout, "< COMMENT, ");
   putLexeme();
   return singleLineComment;
}

{single_line_com2} {
   fprintf(yyout, "< COMMENT, ");
   putLexeme();
   return singleLineComment;
}

{mul_line_com} {
   fprintf(yyout, "< COMMENT, ");
   putLexeme();
   return multiLineComment;
}      
 
.                           {return yytext[0];}

%%

void putLexeme(){
   j = 0;
   while(yytext[j]!='\0'){
      putc(yytext[j], yyout);
      j++;
   }
   fputs(" >\n", yyout);
}

void putIdentifier(){
   j = 0;
   while(yytext[j]!='\0'){
      putc(yytext[j], idout);
      j++;
   }
   fputs(" >\n", idout);
}

int yywrap(void){
   return 1;
}

