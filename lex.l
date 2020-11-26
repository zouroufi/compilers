
%{

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include <string.h>
#include <ctype.h>

#define T_EOF			235
#define T_PROGRAM		95
#define T_CONST			29
#define T_TYPE			126
#define T_ARRAY			6
#define T_SET			111
#define T_OF			80
#define T_RECORD		107
#define T_VAR			130
#define T_FORWARD		59
#define T_FUNCTION		67
#define T_PROCEDURE		90
#define T_INTEGER		77
#define T_REAL			102
#define T_BOOLEAN		19
#define T_CHAR			24
#define T_BEGIN			12
#define T_END			45
#define T_IF			70
#define T_THEN			116
#define T_ELSE			42
#define T_WHILE			136
#define T_DO			32
#define T_FOR			54
#define T_DOWNTO		37
#define T_TO			25
#define T_WITH			140
#define T_READ			100
#define T_WRITE			145
#define T_BCONST		51
#define T_RELOP			226
#define T_ADDOP			225
#define T_OROP			240
#define T_MULDIVANDOP	227
#define T_NOTOP			241
#define T_INOP			239
#define T_LPAREN		228
#define T_RPAREN		229
#define T_SEMI			230
#define T_DOT			326
#define T_COMMA			231
#define T_EQU			232
#define T_COLON			237
#define T_LBRACK		233
#define T_RBRACK		234
#define T_ASSIGN		236
#define T_DOTDOT		325
#define T_CCONST		242
#define T_ICONST		323
#define T_RCONST		324
#define T_ID			149
#define T_COMMENT		238
#define T_STRING		250

#define MAX_STR_LENGTH 255
char string_buf[MAX_STR_LENGTH];
char *string_buf_ptr;
int i=0;

int lineno = 1;

void yyerror(const char msg[]);
void Print_String(int token_id);
void Print_HexToInt(int token);
void Print_BinToInt(int token);
void Print_DecInt(int token);
void Print_DecReal(int token);
void Print_BinRealToInt(int token);
void Print_HexRealToFloat(int token);


%}

%option noyywrap
%option case-insensitive
%x COMMENT 
%x str

/* mnimonika onomata (under construction) */
LETTER						[a-zA-Z]
DIGIT						[0-9]
DIGIT1						[1-9]
WHITESPACE					[ \t]
NEWLINE						[\n]
BACKSLASH					[\\]


EXPONENT					E[+-]?(0|{DIGIT1}{DIGIT}*)
HEX							[0-9A-F]
HEX1						[1-9A-F]
ALPHANUM					[A-Za-z0-9]
ALPHANUM_UNDSCOR			[A-Za-z0-9_]
ASCII						[ -~]

%%

"PROGRAM" 															{Print_String(T_PROGRAM); return T_PROGRAM;}
"CONST"																{Print_String(T_CONST); return T_CONST;}
"TYPE"																{Print_String(T_TYPE); return T_TYPE;}
"ARRAY"																{Print_String(T_ARRAY); return T_ARRAY;}
"SET"																{Print_String(T_SET); return T_SET;}
"OF"																{Print_String(T_OF); return T_OF;}
"RECORD"															{Print_String(T_RECORD); return T_RECORD;}
"VAR"																{Print_String(T_VAR); return T_VAR;}
"FORWARD"															{Print_String(T_FORWARD); return T_FORWARD;}
"FUNCTION"															{Print_String(T_FUNCTION); return T_FUNCTION;}
"PROCEDURE"															{Print_String(T_PROCEDURE); return T_PROCEDURE;}
"IN"																{Print_String(T_INOP); return T_INOP;}
"INTEGER"															{Print_String(T_INTEGER); return T_INTEGER;}
"REAL"																{Print_String(T_REAL); return T_REAL;}
"BOOLEAN"															{Print_String(T_BOOLEAN); return T_BOOLEAN;}
"CHAR"																{Print_String(T_CHAR); return T_CHAR;}
"BEGIN"																{Print_String(T_BEGIN); return T_BEGIN;}
"END"																{Print_String(T_END); return T_END;}
"IF"																{Print_String(T_IF); return T_IF;}
"THEN"																{Print_String(T_THEN); return T_THEN;}
"ELSE"																{Print_String(T_ELSE); return T_ELSE;}
"WHILE"	 															{Print_String(T_WHILE); return T_WHILE;}
"DO"																{Print_String(T_DO); return T_DO;}
"FOR"																{Print_String(T_FOR); return T_FOR;}
"DOWNTO"															{Print_String(T_DOWNTO); return T_DOWNTO;}
"TO"																{Print_String(T_TO); return T_TO;}
"WITH"																{Print_String(T_WITH); return T_WITH;}
"READ"																{Print_String(T_READ); return T_READ;}
"WRITE"																{Print_String(T_WRITE); return T_WRITE;}

"TRUE" | "FALSE"													{Print_String(T_BCONST); return T_BCONST);}
"OR"																{Print_String(T_OROP); return T_OROP;}
"NOT"																{Print_String(T_NOTOP); return T_NOTOP;}
">"|">="|"<"|"<="|"<>"												{Print_String(T_RELOP); return T_RELOP;}
"+"|"-"																{Print_String(T_ADDOP); return T_ADDOP;}
"*"|"/"|"DIV"|"MOD"|"AND"											{Print_String(T_MULDIVANDOP); return T_MULDIVANDOP;}
"("																	{Print_String(T_LPAREN); return T_LPAREN;}
")"																	{Print_String(T_RPAREN); return T_RPAREN;}
";"																	{Print_String(T_SEMI); return T_SEMI;}
"."																	{Print_String(T_DOT); return T_DOT;}
","																	{Print_String(T_COMMA); return T_COMMA;}
"="																	{Print_String(T_EQU); return T_EQU;}
":"																	{Print_String(T_COLON); return T_COLON;}
"["																	{Print_String(T_LBRACK); return T_LBRACK;}
"]"																	{Print_String(T_RBRACK); return T_RBRACK;}
":="																{Print_String(T_ASSIGN); return T_ASSIGN;}
".."																{Print_String(T_DOTDOT); return T_DOTDOT;}

<INITIAL><<EOF>>													{Print_String(T_EOF); return T_EOF;}
"{"											 						BEGIN(COMMENT);
\"																	{string_buf_ptr = string_buf; BEGIN(str);}

<COMMENT>[^}\n]+													;
<COMMENT>\n															{lineno++;}
<COMMENT><<EOF>>													{}      // todo this is an error, we need to handle it
<COMMENT>"}"														BEGIN(INITIAL);

  
<str>\n																{   yyerror("Unterminated String"); }
<str>\\n															{   *string_buf_ptr++ = '\n';       }
<str>\\t															{   *string_buf_ptr++ = '\t';       }
<str>\\r															{   *string_buf_ptr++ = '\r';       }
<str>\\b															{   *string_buf_ptr++ = '\b';       }
<str>\\v															{   *string_buf_ptr++ = '\v';       }
<str>\\f															{   *string_buf_ptr++ = '\f';       }
<str>\\\n															{   /* error_string();*/ lineno++;  }
<str>\\(.)															{   *string_buf_ptr++ = yytext[1];  }
<str>[^\\\n\"]+														{   char *yptr = yytext;
																	while ( *yptr )
																			*string_buf_ptr++ = *yptr++;
																	}
<str><<EOF>>														{   yyerror("Unterminated String"); yyterminate();}
<str>\"																{   BEGIN(INITIAL); *string_buf_ptr = '\0';
																	printf("STRING: %s ", string_buf);
																	printf("| TOKEN ID: %2d ", T_STRING);
																	printf("| LINE: %2d\n\n", lineno);
																	}                                              
											
											
\'{ASCII}\'                 										{Print_String(T_CCONST); return T_CCONST;}
\'\\[nftrbv]\'														{Print_String(T_CCONST); return T_CCONST;}

(_)?{LETTER}({ALPHANUM_UNDSCOR}*{ALPHANUM})*  						{Print_String(T_ID); return T_ID;}

0|{DIGIT1}{DIGIT}*													{Print_DecInt(T_ICONST); return T_ICONST;}
(0B)1[01]*															{Print_BinToInt(T_ICONST); return T_ICONST;}			
(0H)({HEX1}{HEX}*)													{Print_HexToInt(T_ICONST); return T_ICONST;}



0B(1[01]*)?(\.)(([01]*1[01]*)|0)									{Print_BinRealToInt(T_RCONST); return T_RCONST;}


0H({HEX1}{HEX}*)?(\.)(({HEX}*{HEX1}{HEX}*)|0)						{Print_HexRealToFloat(T_RCONST); return T_RCONST;}


(({DIGIT1}{DIGIT}*)|0)?(\.)(00*)?{DIGIT1}{DIGIT}*({EXPONENT})?		{Print_DecReal(T_RCONST); return T_RCONST;}
(({DIGIT1}{DIGIT}*)|0)?(\.)0{EXPONENT}?								{Print_DecReal(T_RCONST); return T_RCONST;}
{DIGIT1}{DIGIT}*({EXPONENT})										{Print_DecReal(T_RCONST); return T_RCONST;}


\n																	{lineno++;}
{WHITESPACE}														{}
.																	yyerror("Illegal input");
	

%%
int main(int argc, char *argv[]) {
	int token;
	
	if(argc > 1){                    
		yyin = fopen(argv[1], "r");
		if(yyin == NULL){
			perror("Error opening file");
			return -1;
		}
	} 
	
	do {
		token = yylex();
	} while (token != T_EOF);
	
	fclose(yyin);           
	yyterminate();
	return 0;
}

void yyerror (const char msg[]) {                           //Otan brei ena error stamataei. Tha emploutistei na sumbadizei me tis apaithseis tou project
	fprintf(stderr, "ERROR, line %d: %s\n", lineno, msg);
	exit(1);
}

void Print_String(int token) {
	printf("TOKEN: %s | TOKEN ID: %d | LINE: %d\n\n", yytext, token, lineno);    
}

void Print_HexToInt(int token) {
	int res = (int) strtol(&yytext[2], NULL, 16);
	printf("TOKEN: %d | TOKEN ID: %d | LINE: %d\n\n", res, token, lineno);
}

void Print_BinToInt(int token) {
	int res = (int) strtol(&yytext[2], NULL, 2);
	printf("TOKEN: %d | TOKEN ID: %d | LINE: %d\n\n", res, token, lineno);
}

void Print_DecInt(int token) {
	int res = atoi(yytext);
	printf("TOKEN: %d | TOKEN ID: %d | LINE: %d\n\n", res, token, lineno);
}

void Print_DecReal(int token) {
	double res = atof(yytext);
	printf("TOKEN: %f | TOKEN ID: %d | LINE: %d\n\n", res, token, lineno);
}

void Print_BinRealToInt(int token) {
	const char *p;
	double num = 0;
	
    for(p = &yytext[2]; *p != '\0' && isspace(*p); p++);
	for(; *p != '\0' && isdigit(*p); p++)
		num = 2 * num + (*p - '0');

	if(*p == '.') {
		double fac = 2;
		for(p++; *p != '\0' && isdigit(*p); p++) {
			num += (*p - '0') / fac;
			fac *= 2;
		}
	}
	printf("TOKEN: %f | TOKEN ID: %d | LINE: %d\n\n", num, token, lineno);
}

//todo beltiwsh ths sunarthshs gia perissotera dekadika psifia
void Print_HexRealToFloat(int token){
	double num = 0.0;
	int i, length;
	char *character;
	
	character = strchr(yytext,'.');
	length = strlen(character)-1;
	num = (int)strtol(&yytext[2], &character,16);
	for(i=1;i<=length;i++){
		if(character[i] <= '9')
			num += (character[i] - '0') * (1/pow(16,i));
		else
			num += (character[i] + 10 - 'A') * (1/pow(16,i));
	}
	printf("TOKEN: %f | TOKEN ID: %d | LINE: %d\n\n", num, token, lineno);
}

