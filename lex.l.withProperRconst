


%{
#define T_EOF			0
#define T_PROGRAM		1
#define T_CONST			2
#define T_TYPE			3
#define T_ARRAY			4
#define T_SET			5
#define T_OF			6
#define T_RECORD		7
#define T_VAR			8
#define T_FORWARD		9
#define T_FUNCTION		10
#define T_PROCEDURE		11
#define T_INTEGER		12
#define T_REAL			13
#define T_BOOLEAN		14
#define T_CHAR			15
#define T_BEGIN			16
#define T_END			17
#define T_IF			18
#define T_THEN			19
#define T_ELSE			20
#define T_WHILE			21
#define T_DO			22
#define T_FOR			23
#define T_DOWNTO		24
#define T_TO			25
#define T_WITH			26
#define T_READ			27
#define T_WRITE			28
#define T_BCONST		29
#define T_RELOP			30
#define T_ADDOP			31
#define T_OROP			32
#define T_MULDIVANDOP	33
#define T_NOTOP			34
#define T_INOP			35
#define T_LPAREN		36
#define T_RPAREN		37
#define T_SEMI			38
#define T_DOT			39
#define T_COMMA			40
#define T_EQU			41
#define T_COLON			42
#define T_LBRACK		43
#define T_RBRACK		44
#define T_ASSIGN		45
#define T_DOTDOT		46
#define T_CCONST		47
#define T_ICONST		48
#define T_RCONST		49
#define T_ID			50
#define T_STRING		51


int lineno = 1;

void ERROR (const char msg []);
void Print_String(int token_id);
%}

%option noyywrap
%option case-insensitive
%x COMMENT 
%x STRING

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
ASCII               		[ -~]

%%

"PROGRAM" 					{Print_String(T_PROGRAM); return T_PROGRAM;}
"CONST"						{Print_String(T_CONST); return T_CONST;}
"TYPE"						{Print_String(T_TYPE); return T_TYPE;}
"ARRAY"						{Print_String(T_ARRAY); return T_ARRAY;}
"SET"						{Print_String(T_SET); return T_SET;}
"OF"						{Print_String(T_OF); return T_OF;}
"RECORD"					{Print_String(T_RECORD); return T_RECORD;}
"VAR"						{Print_String(T_VAR); return T_VAR;}
"FORWARD"					{Print_String(T_FORWARD); return T_FORWARD;}
"FUNCTION"  				{Print_String(T_FUNCTION); return T_FUNCTION;}
"PROCEDURE"					{Print_String(T_PROCEDURE); return T_PROCEDURE;}
"INTEGER"					{Print_String(T_INTEGER); return T_INTEGER;}
"REAL"						{Print_String(T_REAL); return T_REAL;}
"BOOLEAN"					{Print_String(T_BOOLEAN); return T_BOOLEAN;}
"CHAR"						{Print_String(T_CHAR); return T_CHAR;}
"BEGIN"						{Print_String(T_BEGIN); return T_BEGIN;}
"END"						{Print_String(T_END); return T_END;}
"IF"						{Print_String(T_IF); return T_IF;}
"THEN"						{Print_String(T_THEN); return T_THEN;}
"ELSE"						{Print_String(T_ELSE); return T_ELSE;}
"WHILE"	 					{Print_String(T_WHILE); return T_WHILE;}
"DO"						{Print_String(T_DO); return T_DO;}
"FOR"						{Print_String(T_FOR); return T_FOR;}
"DOWNTO"					{Print_String(T_DOWNTO); return T_DOWNTO;}
"TO"						{Print_String(T_TO); return T_TO;}
"WITH"						{Print_String(T_WITH); return T_WITH;}
"READ"						{Print_String(T_READ); return T_READ;}
"WRITE"						{Print_String(T_WRITE); return T_WRITE;}

"TRUE" | "FALSE"			{Print_String(T_BCONST); return T_BCONST);}
">"|">="|"<"|"<="|"<>"		{Print_String(T_RELOP); return T_RELOP;}
"+"|"-"						{Print_String(T_ADDOP); return T_ADDOP;}
"OR"						{Print_String(T_OROP); return T_OROP;}
"*"|"/"|"DIV"|"MOD"|"AND"	{Print_String(T_MULDIVANDOP); return T_MULDIVANDOP;}
"NOT"						{Print_String(T_NOTOP); return T_NOTOP;}
"IN"						{Print_String(T_INOP); return T_INOP;}

"(" 						{Print_String(T_LPAREN); return T_LPAREN;}
")"							{Print_String(T_RPAREN); return T_RPAREN;}
";"							{Print_String(T_SEMI); return T_SEMI;}
"."							{Print_String(T_DOT); return T_DOT;}
","							{Print_String(T_COMMA); return T_COMMA;}
"="							{Print_String(T_EQU); return T_EQU;}
":"							{Print_String(T_COLON); return T_COLON;}
"["							{Print_String(T_LBRACK); return T_LBRACK;}
"]"							{Print_String(T_RBRACK); return T_RBRACK;}
":="						{Print_String(T_ASSIGN); return T_ASSIGN;}
".."						{Print_String(T_DOTDOT); return T_DOTDOT;}

<INITIAL><<EOF>>			{Print_String(T_EOF); return T_EOF;}



"{"							BEGIN(COMMENT);
<COMMENT>[^}\n]+			;
<COMMENT>\n					{lineno++;}
<COMMENT><<EOF>>			{}
<COMMENT>"}"				BEGIN(INITIAL);



\'{ALPHANUM}\'					            	{Print_String(T_CCONST); return T_CCONST;}
\'{ASCII}\'                 					{Print_String(T_CCONST); return T_CCONST;}
\'\\[nftrbv]\'									{Print_String(T_CCONST); return T_CCONST;}

(\"{ASCII}*\")|(\"{ASCII}*\\\n{ASCII}*\")		{Print_String(T_STRING); return T_STRING;}

(_)?{LETTER}({ALPHANUM_UNDSCOR}*{ALPHANUM})*  	{Print_String(T_ID); return T_ID;}

0|{DIGIT1}{DIGIT}*								{Print_String(T_ICONST); return T_ICONST;}
(0B)1[01]*										{Print_String(T_ICONST); return T_ICONST;}			
(0H)({HEX1}{HEX}*)								{Print_String(T_ICONST); return T_ICONST;}



(0B(\.)00*1[01]*)|(0B(\.)1[01]*)|(0B1[01]*(\.)1[01]*)|(0B1[01]*(\.)00*1[01]*)	{Print_String(T_RCONST); return T_RCONST;}
(0H(\.){HEX1}{HEX}*)|(0H(\.)00*{HEX1}{HEX}*)									{Print_String(T_RCONST); return T_RCONST;}
(({DIGIT1}{DIGIT}*)|0)?(\.)(00*)?{DIGIT1}{DIGIT}*({EXPONENT})?					{Print_String(T_RCONST); return T_RCONST;}
{DIGIT1}{DIGIT}*({EXPONENT})													{Print_String(T_RCONST); return T_RCONST;}
(0H{HEX1}{HEX}*(\.){HEX1}{HEX}*)												{Print_String(T_RCONST); return T_RCONST;}
(0H{HEX1}{HEX}*(\.)0[0]*{HEX1}{HEX}*)											{Print_String(T_RCONST); return T_RCONST;}
0B1[01]*\.0 | 0B1[01]*\.00*1[01]*												{Print_String(T_RCONST); return T_RCONST;}
0H{HEX1}{HEX}*\.0 | 0H{HEX1}{HEX}*\.00*{HEX1}{HEX}*								{Print_String(T_RCONST); return T_RCONST;}
(0B(\.)0)|(0H(\.)0)|({DIGIT1}{DIGIT}*(\.)0)										{Print_String(T_RCONST); return T_RCONST;}
(({DIGIT1}{DIGIT}*)|0)?(\.)0{EXPONENT}?											{Print_String(T_RCONST); return T_RCONST;}



\n							{lineno++;}

%%

int main() {
	int token;
	
	do {
		token = yylex();
	} while (token != T_EOF);
	
	return 0;
}

void ERROR (const char msg[]) {
		fprintf(stderr, "ERROR, line %d: %s\n", lineno, msg);
			exit(1);
}

void Print_String(int token) {
    //if(FLEX_DEBUG && SHOW_TOKENS)
        printf("TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d\n\n", yytext, token, lineno);
       
}

