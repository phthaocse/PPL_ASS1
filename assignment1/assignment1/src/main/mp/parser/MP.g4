grammar MP;

@lexer::header {
from lexererr import *
}

options{
	language=Python3;
}

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

program: mptype 'main' LB RB LP body? RP EOF ;

mptype: INTTYPE | VOIDTYPE ;

INTTYPE: 'int' ;

VOIDTYPE: 'void'  ;

progcedure_main: PROCEDURE 'main' LB RB LP SEMI BEGIN body? END EOF ;

declaration: var_dec | fun_dec | procedure_dec ;

var_dec: VAR idlist COLON TYPE SEMI ;

fun_dec: FUNCTION ID LB paralist RB COLON return_type SEMI var_dec? compoundStatement ;

procedure_dec: PROCEDURE ID LB paralist RB SEMI var_dec compoundStatement ;

idlist: ID COMMA idlist | ID;

varlist_dec: var_dec varlist_dec | var_dec ;

paralist: para_dec SEMI paralist | para_dec | empty ;

para_dec: idlist COLON TYPE ;

body
	: declaration body 
	| declaration 
	| statements body 
	| statements
	;

listexp: expression listexp | expression ;

funcall: ID LB listexp? RB ;

ID: [A-Z_][A-Z0-9_]* ;

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

OF: O F;

REAL: R E A L;

BOOLEAN: B O O L E A N;

INTEGER: I N T E G E R;

STRING: S T R I N G;

NOT: N O T;

AND: A N D;

OR: O R;

DIV: D I V;

MOD: M O D;

WITH: W I T H;
//OPERATOR

ADDITION: '+';

SUBTRACTION: '-';

MULTIPLICATION: '*';

DIVISION: '/';

NOT_LOGIC: NOT ;

MODULUS: MOD ;

OR_LOGIC: OR ;

AND_LOGIC: AND ;

NOT_EQUAL: '<>';

EQUAL: '=';

LESS_THAN: '<';

GREATER_THAN: '>';

LESS_THAN_EQUAL: '<=';

GREATER_THAN_EQUAL: '>=';

INT_DEVISION: 'div';

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

//TYPE AND VALUE
TYPE: PRIMITIVE_TYPES | COMBOUND_TYPE ;

PRIMITIVE_TYPES: ( BOOLEAN | INTEGER | REAL | STRING );

COMBOUND_TYPE: ARRAY;

return_type: TYPE ;

array_dec: ARRAY LSB INTLIT DD INTLIT RSB OF TYPE ;

indexExpression
	: array_type LSB INTLIT RSB
	| array_type LSB intexpression RSB
	| array_type LSB indexExpression RSB
	;

array_type: ID | funcall ;

intexpression
	: INTLIT indexoperator INTLIT 
	| INTLIT indexoperator indexExpression
	| indexExpression indexoperator INTLIT
	;

expression: simple_exp (operandOperator expression)? ;

simple_exp
	: simple_exp AND_LOGIC THEN simple_exp1
	| simple_exp OR_LOGIC ELSE simple_exp1
	| simple_exp1
	;

simple_exp1
	: simple_exp1 compareOperator simple_exp1
	| simple_exp2
	;

simple_exp2
	: simple_exp2 ADDITION simple_exp3
	| simple_exp2 SUBTRACTION simple_exp3
	| simple_exp2 OR_LOGIC simple_exp3
	| simple_exp3
	;

simple_exp3
	: simple_exp3 DIVISION simple_exp4
	| simple_exp3 MULTIPLICATION simple_exp4
	| simple_exp3 DIV simple_exp4
	| simple_exp3 MOD simple_exp4
	| simple_exp3 AND_LOGIC simple_exp4
	| simple_exp4
	;

simple_exp4
	: NOT simple_exp4
	| SUBTRACTION simple_exp4
	| LB simple_exp RB
	| operand
	;

operand
	: literals
	| ID
	| indexExpression
	| funcall
	;
unaryOperator
	: NOT
	;

compareOperator
	: LESS_THAN
	| LESS_THAN_EQUAL
	| GREATER_THAN
	| GREATER_THAN_EQUAL
	| NOT_EQUAL
	| EQUAL
	;

operandOperator
	: ADDITION
	| SUBTRACTION
	| MULTIPLICATION
	| DIVISION
	| LESS_THAN
	| LESS_THAN_EQUAL
	| GREATER_THAN
	| GREATER_THAN_EQUAL
	| NOT_EQUAL
	| EQUAL
	;

binaryOperator
	: AND_LOGIC
	| AND_LOGIC THEN
	| OR_LOGIC
	| OR_LOGIC ELSE
	| ADDITION
	| SUBTRACTION
	| MULTIPLICATION
	| DIV
	| MOD
	| LESS_THAN
	| LESS_THAN_EQUAL
	| GREATER_THAN
	| GREATER_THAN_EQUAL
	| NOT_EQUAL
	| EQUAL
	| DIVISION
	;

intoperator
	: ADDITION
	| SUBTRACTION
	| MULTIPLICATION
	| DIV
	| MOD
	| LESS_THAN
	| LESS_THAN_EQUAL
	| GREATER_THAN
	| GREATER_THAN_EQUAL
	| NOT_EQUAL
	| EQUAL
	| DIVISION
	;

indexoperator
	: ADDITION
	| SUBTRACTION
	| MULTIPLICATION
	| DIV
	| MOD
	| DIVISION
	;

booloperator
	: NOT
	| AND_LOGIC
	| AND_LOGIC THEN
	| OR_LOGIC
	| OR_LOGIC ELSE
	;
//statement
assignstatement: (variable ASSIGN)+ expression ;

variable: ID | indexExpression;

ifstatement: IF expression THEN statements (: ELSE statements)? ;

whilestatement: WHILE expression DO  statements ;

forstatement: FOR ID ASSIGN initialExp (TO | DOWNTO) finalExp DO statements ;

initialExp: expression;

finalExp: expression;

breakstatement: BREAK SEMI ;

continuestatement: CONTINUE SEMI ;

returnstatement: RETURN expression SEMI ;

compoundStatement: BEGIN statements END ;

withstatements: WITH varlist_dec DO statements;

callstatements: ID LB expList RB SEMI ;

expList: expression COMMA expList | expression | empty;

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




WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines

COMMENT_1
   : '(*' .*? '*)' -> skip ;


COMMENT_2
   : '{' .*? '}' -> skip ;

COMENT_3
	:  '//' ~[\r\n]* -> skip ;

empty
   :
   /* empty */
   ;
ERROR_CHAR: .;
UNCLOSE_STRING: .;
ILLEGAL_ESCAPE: .;