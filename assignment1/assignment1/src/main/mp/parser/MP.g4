/*
   **************************************
    Student name: Phan Thao 
    Student ID: 1613135                
   **************************************
*/
grammar MP;

@lexer::header {
from lexererr import *
}

options{
	language=Python3;
}


program: many_declarations ;

many_declarations: many_declarations declaration | declaration;

declaration: var_dec | fun_dec | procedure_dec ;

var_dec: VAR varlist_dec ;
 
varlist_dec: one_var_dec varlist_dec | one_var_dec ; 

one_var_dec:  idlist COLON TYPE SEMI ;

idlist: ID COMMA idlist | ID;

fun_dec: FUNCTION ID LB paralist RB COLON TYPE SEMI (var_dec)? compoundStatement ;

procedure_dec: PROCEDURE ID LB paralist RB SEMI var_dec compoundStatement ;

paralist: para_dec SEMI paralist | (para_dec)? ;

para_dec: idlist COLON TYPE ;

TYPE: PRIMITIVE_TYPES | COMBOUND_TYPE ;


fragment A: [aA];
fragment B: [bB];
fragment C: [cC];
fragment D: [dD];
fragment E: [eE];
fragment F: [fF];
fragment G: [gG];
fragment H: [hH];
fragment I: [iI];
fragment J: [jJ];
fragment K: [kK];
fragment L: [lL];
fragment M: [mM];
fragment N: [nN];
fragment O: [oO];
fragment P: [pP];
fragment Q: [qQ];
fragment R: [rR];
fragment S: [sS];
fragment T: [tT];
fragment U: [uU];
fragment V: [vV];
fragment W: [wW];
fragment X: [xX];
fragment Y: [yY];
fragment Z: [zZ];

COMMENT_1
   : '(*' .*? '*)' -> skip ;


COMMENT_2
   : '{' .*? '}' -> skip ;

COMENT_3
	:  '//' ~[\r\n]* -> skip ;


//KEYWORD



BREAK: B R E A K;

CONTINUE: C O T I N U E;

FOR: F O R;

TO: T O;

DOWNTO: D O W N T O;

DO: D O;

IF: I F;

THEN: T H E N;

ELSE: E L S E;

RETURN: R E T U R N;

WHILE: W H I L E;

BEGIN: B E G I N;

END: E N D;

FUNCTION: F U N C T I O N;

PROCEDURE: P R O C E D U R E;

VAR: V A R;

TRUE: T R U E;

FALSE: F A L S E;

ARRAY: A R R A Y;

ANDTHEN: A N D ' ' T H E N;

ORELSE: O R ' ' E L S E;

OF: O F;

REAL: R E A L;

BOOLEAN: B O O L E A N;

INTEGER: I N T E G E R;

STRING: S T R I N G;


WITH: W I T H;
//OPERATOR

ADD: '+';

SUB: '-';

MULTIPLICATION: '*';

DIVISION: '/';

NOT: N O T ;

AND: A N D;

OR: O R;

NOT_EQUAL: '<>';

EQUAL: '=';

LESS_THAN: '<';

GREATER_THAN: '>';

LESS_THAN_EQUAL: '<=';

GREATER_THAN_EQUAL: '>=';

DIV: D I V;

MOD: M O D;

//SEPARATORS

LSB: '[';

RSB: ']';

LB: '(' ;

RB: ')' ;

LP: '{';

RP: '}';

SEMI: ';' ;

DD: '..';

COMMA: ',';

COLON: ':' ;

ASSIGN: ':=' ;

//LITERALS
literals
	: INTLIT 
	| FLOATLIT
	| BOOL_LIT
	| STRING_LIT
	;

INTLIT: [0-9]+;

FLOATLIT: FRACPART EXPOPART?  | [0-9]+ EXPOPART;

fragment FRACPART: INTLIT? '.' INTLIT | INTLIT '.';

fragment EXPOPART: E SIGN? INTLIT;

fragment SIGN: '-';

BOOL_LIT: TRUE | FALSE;

STRING_LIT: '"' (STR_EXCEPT)* '"';

fragment STR_EXCEPT: ~[\b\f\r\n\t'"\\]+;
//TYPE AND VALUE

PRIMITIVE_TYPES: ( BOOLEAN | INTEGER | REAL | STRING );

COMBOUND_TYPE: ARRAY;

array_dec: ARRAY LSB expression DD expression RSB OF PRIMITIVE_TYPES ;

operand
	: literals
	| ID
	| funcall
	;

expression:
    expression ANDTHEN expression1
    | expression ORELSE expression1
    | expression1
    | operand
    ;

expression1:
    expression2 EQUAL expression2
    | expression2 NOT_EQUAL expression2
    | expression2 LESS_THAN expression2
    | expression2 GREATER_THAN expression2
    | expression2 LESS_THAN_EQUAL expression2
    | expression2 GREATER_THAN_EQUAL expression2
    | expression2
    ;

expression2:
    expression2 ADD expression3
    | expression2 SUB expression3
    | expression2 OR expression3
    | expression3
    ;

expression3:
    expression3 DIVISION expression4
    | expression3 MULTIPLICATION expression4
    | expression3 DIV expression4
    | expression3 MOD expression4
    | expression3 AND expression4
    | expression4
    ;

expression4:
    SUB expression4
    | NOT expression4
    | expression5
    ;

expression5:
    expression5 LSB expression RSB
    | expression6
    ;
    
expression6:
    LB expression RB
    | operand
    ;
arrayelement:
    expression5 LSB expression RSB
    ;

funcall: ID LB listexp? RB ;

listexp: expression COMMA listexp | expression ;

//statement

compoundStatement: BEGIN (lis_statements)? END ;

statements
	: assignstatement
	| ifstatement
	| whilestatement
	| forstatement
	| breakstatement
	| continuestatement
	| returnstatement
	| compoundStatement
	| withstatements
	| callstatements
	;

assignstatement: (variable ASSIGN)+ expression SEMI ;

variable: ID | arrayelement;

ifstatement: IF expression THEN statements (: ELSE statements)? ;

whilestatement: WHILE expression DO  statements ;

forstatement: FOR ID ASSIGN initialExp (TO | DOWNTO) finalExp DO statements ;

initialExp: expression;

finalExp: expression;

breakstatement: BREAK SEMI ;

continuestatement: CONTINUE SEMI ;

returnstatement: RETURN expression? SEMI ;

lis_statements: statements lis_statements | statements ;

withstatements: WITH varlist_dec DO statements;

callstatements: funcall SEMI ;


ID: [a-zA-Z_][a-zA-Z0-9_]* ;

WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines

 /*ERROR_CHAR: .;
UNCLOSE_STRING: .;
ILLEGAL_ESCAPE: .; 
 
*/
 /*grammar MP;
 @lexer::header {
from lexererr import *
}
 options{
	language=Python3;
}
 program  : mptype 'main' LB RB LP body? RP EOF ;
 mptype: INTTYPE | VOIDTYPE ;
 body: funcall SEMI;
 exp: funcall | INTLIT ;
 funcall: ID LB exp? RB ;
 INTTYPE: 'int' ;
 VOIDTYPE: 'void'  ;
 ID: [a-zA-Z]+ ;
 INTLIT: [0-9]+;
 LB: '(' ;
 RB: ')' ;
 LP: '{';
 RP: '}';
 SEMI: ';' ;
 WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines
 ERROR_CHAR: .;
UNCLOSE_STRING: .;
ILLEGAL_ESCAPE: .; 
*/