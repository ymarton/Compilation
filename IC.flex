
import java_cup.runtime.*;

%%

%line
%column
%scanerror LexicalError
%type Token
%class Lexer
%cup

%{
	StringBuilder stringBuilder = new StringBuilder();
	String stringLine;
	String stringColumn;
	
	Token makeToken(int id, String tag) {
		return new Token(id, yyline, yycolumn, tag, yytext());
	}

	Token makeToken(int id) {
		return new Token(id, yyline, yycolumn, yytext(), yytext());
	}
%}
UPPERCASE = [A-Z]
LOWWERCASE = [a-z]
ALPHA = {UPPERCASE}|{LOWWERCASE}
DIGIT = [0-9]
UNDERSCORE = _
ALPHA_NUMERIC = {ALPHA}|{DIGIT}|{UNDERSCORE}
ID = {ALPHA}({ALPHA_NUMERIC})*
CLASS_ID = [A-Z]({ALPHA_NUMERIC})*
INTEGER = 0|-?[1-9]({DIGIT})*
NEWLINE = \n|\r|\n\r
WHITESPACE = [ ]|{NEWLINE}|\t	
STRING_CHAR = [^\r\n\"\\]

%state COMMENTS1
%state COMMENTS2
%state STRING

%%

<YYINITIAL>{
	{WHITESPACE}	{}
	"class"		{return makeToken(sym.CLASS);}
	"extends"	{return makeToken(sym.EXTENDS);}
	"static"	{return makeToken(sym.STATIC);}
	"void"	{return makeToken(sym.VOID);}
	"int"	{return makeToken(sym.INT);}
	"boolean"	{return makeToken(sym.BOOLEAN);}
	"string"	{return makeToken(sym.STRING);}
	"return"	{return makeToken(sym.RETURN);}
	"if"	{return makeToken(sym.IF);}
	"else"	{return makeToken(sym.ELSE);}
	"while"	{return makeToken(sym.WHILE);}
	"break"	{return makeToken(sym.BREAK);}
	"continue"	{return makeToken(sym.CONTINUE);}
	"this"	{return makeToken(sym.THIS);}
	"new"	{return makeToken(sym.NEW);}
	"length"	{return makeToken(sym.LENGTH);}
	"true"	{return makeToken(sym.TRUE);}
	"false"	{return makeToken(sym.FALSE);}
	"null"	{return makeToken(sym.NULL);}

	{ID}	{return makeToken(sym.ID, "ID");}
	{CLASS_ID}	{return makeToken(sym.CLASS_ID, "CLASS_ID");}
	{INTEGER}	{return makeToken(sym.INTEGER, "INTEGER");}
	\"	{yybegin(STRING); stringBuilder.setLength(0); stringLine = yyline; stringColumn = yycolumn;}
	
	"//"	{yybegin(COMMENTS1);}
	"/*"	{yybegin(COMMENTS2);}
	
	"=="                           {return makeToken(sym.EQUAL);}
	"="                            {return makeToken(sym.ASSIGNMENT);}
	"<="                           {return makeToken(sym.SMALLER_OR_EQUAL);}
	">="                           {return makeToken(sym.GREATER_OR_EQUAL);}
	">"                            {return makeToken(sym.GREATER);}
	"<"                            {return makeToken(sym.SMALLER);}
	"!="                           {return makeToken(sym.NOT_EQUAL);}
	"!"                            {return makeToken(sym.NOT);}
	"&&"                           {return makeToken(sym.AND);}
	"||"                           {return makeToken(sym.OR);}
	"+"                            {return makeToken(sym.PLUS);}
	"-"                            {return makeToken(sym.MINUS);}
	"."								{return makeToken(sym.DOT);}
	","								{return makeToken(sym.COMMA);}
	";"								{return makeToken(sym.DELIMETER);}
	"["								{return makeToken(sym.LEFT_BRACES);}
	"]"								{return makeToken(sym.RIGHT_BRACES);}
	"("								{return makeToken(sym.LEFT_PARENTHESES);}
	")"								{return makeToken(sym.RIGHT_PARENTHESES);}
	"*"								{return makeToken(sym.MULTIFICATION);}
	"/"								{return makeToken(sym.DIVITION);}
	"%"								{return makeToken(sym.MODULO);}
}

<COMMENTS1> {
	^{NEWLINE} { }
	{NEWLINE} {yybegin(YYINITIAL);}
}

<COMMENTS2> {
	^"*/" {}
	"*/" {yybegin(YYINITIAL);}
}
	
<STRING> {
	\"							{yybegin(YYINITIAL); {return makeToken(sym.STRING, "STRING"); }
	{STRING_CHAR}+             {string.append(yytext());}
	"\\b"                          { string.append( '\b' ); }
	"\\t"                          { string.append( '\t' ); }
	"\\n"                          { string.append( '\n' ); }
	"\\f"                          { string.append( '\f' ); }
	"\\r"                          { string.append( '\r' ); }
	"\\\""                         { string.append( '\"' ); }
	"\\'"                          { string.append( '\'' ); }
	"\\\\"                         { string.append( '\\' ); }
}

