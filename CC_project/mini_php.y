%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex();
    int yyerror();
    int isCodeCompiled = 1;
%}

//Keyword tokkens
%token ifKeyWord elseKeyWord whileKeyWord echoKeyWord functionKeyWord

//Identifiers and comment tokkens
%token identifier singleLineComment multiLineComment codeBlockStart codeBlockEnd

//Literal tokkens
%token characterLiteral stringLiteral integerLiteral floatLiteral

//Operator tokkens
%token plusOperator minusOperator multiplyOperator divideOperator
%token squareOperator modulusOperator lessThanOperator greaterThanOperator
%token lessThanEqualToOperator greaterThanEqualToOperator
%token equalEqualToOperator equalToOperator notEqualToOperator

//Bracket tokkens
%token curlyBracketOpen curlyBracketClose squareBracketOpen squareBracketClose
%token paranthesisOpen paranthesisClose semicolon comma dot

//Error tokken
%token undefinedID

%%

Program: 
        codeBlockStart STATEMENT_LIST codeBlockEnd 
        {
                if(isCodeCompiled == 1){
                        printf("\n******************************\n");
                        printf("Code Compiled Successfully! :)"); 
                        printf("\n******************************\n");
                }
                else{
                        printf("\n*****************************\n");
                        printf("Compilation failed! :(\n");
                        printf("\nYour code contains error\
 which you can see in file named \"error.txt\"\n"); 
                        printf("\n*****************************\n");
                }
                exit(0);
        }
        ;


STATEMENT_LIST: 
        STATEMENT STATEMENT_LIST
        | /*epsilon*/
        ;


STATEMENT: 
        IF_STATEMENT
        | ASIGNMENT_STATEMENT semicolon
        | LOOP_STATEMENT
        | ECHO_STATEMENT semicolon
        | FUNCTION_STATEMENT
        | singleLineComment
        | multiLineComment
        | undefinedID {
                if(isCodeCompiled == 1){
                        isCodeCompiled = 0;
                }
        }
        ;


IF_STATEMENT: 
        ifKeyWord paranthesisOpen EXPRESSION_STATEMENT paranthesisClose
        curlyBracketOpen STATEMENT STATEMENT_LIST curlyBracketClose ElSE_STATEMENT
        ;


ElSE_STATEMENT: 
        elseKeyWord curlyBracketOpen STATEMENT STATEMENT_LIST curlyBracketClose
        | /*epsilon*/   
        ;


ASIGNMENT_STATEMENT:     
        identifier equalToOperator EXPRESSION_STATEMENT
        ;


LOOP_STATEMENT: 
        whileKeyWord paranthesisOpen EXPRESSION_STATEMENT paranthesisClose
        curlyBracketOpen STATEMENT STATEMENT_LIST curlyBracketClose
        ;

        
ECHO_STATEMENT:
        echoKeyWord stringLiteral
        | echoKeyWord stringLiteral dot stringLiteral
        | echoKeyWord characterLiteral
        | echoKeyWord integerLiteral
        | echoKeyWord floatLiteral
        | echoKeyWord stringLiteral dot identifier dot stringLiteral
        | echoKeyWord identifier
        ;


FUNCTION_STATEMENT:
        functionKeyWord identifier paranthesisOpen paranthesisClose
        curlyBracketOpen STATEMENT STATEMENT_LIST curlyBracketClose
        ;


EXPRESSION_STATEMENT: 
        paranthesisOpen EXPRESSION_STATEMENT paranthesisClose EXPRESSION_STATEMENT1
        | identifier EXPRESSION_STATEMENT1
        | integerLiteral EXPRESSION_STATEMENT1
        | characterLiteral EXPRESSION_STATEMENT1
        | stringLiteral EXPRESSION_STATEMENT1
        ;


EXPRESSION_STATEMENT1: 
        OPERATOR EXPRESSION_STATEMENT EXPRESSION_STATEMENT1
        | /*epsilon*/
        ;


OPERATOR: 
        plusOperator
        | minusOperator
        | multiplyOperator
        | divideOperator
        | squareOperator
        | equalEqualToOperator
        | lessThanOperator
        | greaterThanOperator
        | lessThanEqualToOperator
        | greaterThanEqualToOperator
        | modulusOperator
        | notEqualToOperator
        ;


%%

int main() {
        extern FILE *yyin, *yyout, *idout, *errorOut;
        yyin = fopen("source.txt", "r");
        yyout = fopen("tokken.txt", "w");
        idout = fopen("identifier.txt", "w");
        errorOut = fopen("error.txt", "w");
        yyparse();
        return 0;
}

int yyerror(char const *s){
        printf("\n*****************************\n");
        printf("Error ageya :(\n-> %s\nSahi PHP likhain next time...", s);
        printf("\n*****************************\n");
        exit(0);
}