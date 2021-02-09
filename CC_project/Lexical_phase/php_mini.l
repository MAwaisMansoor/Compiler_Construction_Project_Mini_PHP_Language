%{
   #include<stdio.h>
   #include"mini_php.tab.h"
   int d = 0;
   int j = 0;
   int no_of_lines = 0;
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

[\n]                        {++no_of_lines; return NL;} 
{del}+                      {}
[Ii][fF]                    {return 1;}
[Ee][Ll][Ss][Ee]            {return 1;}
[Ee][Cc][Hh][Oo]            {return 1;}
[Ww][Hh][Ii][Ll][Ee]        {return 1;}
[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]        {return 1;}
"<?"[Pp][Hh][Pp]            {return 8;}
"?>"                        {return 11;}
"+"|"-"|"%"|"*"|"**"|"/"|"<"|">"|"<="|">="|"=="|"="|"!=" {return 2;}
"["|"]"|"{"|"}"|"("|")"|";"|"," {return 3;}
{chr}                       {return 4;}
{str}                       {return 5;}
({digit})+                  {return 7;}
"$"({let}|{digit})*         {return 6;}
({let}|{digit})*            {return 6;}   
{float}                     {return 9;}
{single_line_com1}          {return 10;}
{single_line_com2}          {return 10;}
{mul_line_com}              {return 12;}       
.                           {return -1;}

%%

int yywrap(void){}

int allTokens() {
   yyin = fopen("source.txt","r"); 
   yyout = fopen("tokken.txt","w"); 
  
   if (yyin == 0) {
      fprintf(stderr,"Cant open %s\n", "source.txt");
      return 1;
   }
   
   if (yyout == 0) {
      fprintf(stderr,"Cant open %s\n", "tokken.txt");
      return 1;
   }

   d = yylex();
      
   while(d != 0){
      if(d == -1) fputs("< ERROR, ", yyout);
      else if(d == 1) fputs("< KW, ", yyout);
      else if(d == 2) fputs("< OP, ", yyout);
      else if(d == 3) fputs("< PUN, ", yyout);
      else if(d == 4) fputs("< CHRLIT, ", yyout);
      else if(d == 5) fputs("< STRLIT, ", yyout);
      else if(d == 6) fputs("< ID, ", yyout);
      else if(d == 7) fputs("< INTLIT, ", yyout);
      else if(d == 8) fputs("< CODEBLOCSTART, ", yyout);
      else if(d == 11) fputs("< CODEBLOCEND, ", yyout);
      else if(d == 9) fputs("< FLOATLIT, ", yyout);
      else if(d == 10) fputs("< COMMENT, ", yyout);
      else if(d == 12) fputs("< COMMENT, ", yyout);

     
      j = 0;
      while(yytext[j]!='\0'){
         putc(yytext[j], yyout);
         j++;
      }
      fputs(" >", yyout);   
      

      if(d == -1){
         fputs(" < LINE NO, ", yyout);
         fprintf(yyout, "%d", no_of_lines+1);
         fputs(" >", yyout);
      }
      putc('\n', yyout);

      d = yylex();
   }
}

int identifier() {
   yyin = fopen("source.txt","r"); 
   yyout = fopen("identifier.txt","w"); 
  
   if (yyin == 0) {
      fprintf(stderr,"Cant open %s\n", "source.txt");
      return 1;
   }
   
   if (yyout == 0) {
      fprintf(stderr,"Cant open %s\n", "identifier.txt");
      return 1;
   }

   d = yylex();
      
   while(d != 0){
      if(d == 6) {
         fputs("< ID, ", yyout);
     
         j = 0;
         while(yytext[j]!='\0'){
            putc(yytext[j], yyout);
            j++;
         }
         fputs(" >", yyout);  
         putc('\n', yyout); 
      }
      d = yylex();
   }
}

int main(int argc, char* argv[]) {
   
   allTokens();
   identifier();   
   
   return 0;
}

