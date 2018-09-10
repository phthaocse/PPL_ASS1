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

program  : mptype 'main' LB RB LP body? RP EOF ;

mptype: INTTYPE | VOIDTYPE ;

body: funcall SEMI;

exp: funcall | INTLIT ;

funcall: ID LB exp? RB ;

INTTYPE: 'int' ;

VOIDTYPE: 'void'  ;

ID: [A-Z_][A-Z0-9_]* ;

//LITERALS

INTLIT: [0-9]+;

FLOATLIT: FRACPART EXPOPART?  | [0-9]+ EXPOPART;

fragment FRACPART: [0-9]+? '.' [0-9]+ | [0-9]+ '.';

fragment EXPOPART: E SIGN? [0-9]+;

fragment SIGN: '-';

BOOL_LIT: TRUE | FALSE;

STRING_LIT: '\"' (STR_EXCEPT)* '\"';

fragment STR_EXCEPT: ~[\b\f\r\n\t\'\"\\]+;
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

//OPERATOR

ADDITION: '+';

SUBTRACTION: '-';

MULTIPLICATION: '*';

DIVISION: '/';

NOT_LOGIC: 'not';

MODULUS: 'mod';

OR_LOGIC: 'or';

AND_LOGIC: 'and';

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

//LITERALS

//TYPE AND VALUE

PRIMITIVE_TYPES: ( BOOLEAN | INTEGER | REAL | STRING );

COMBOUND_TYPE: ARRAY;

WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines


ERROR_CHAR: .;
UNCLOSE_STRING: .;
ILLEGAL_ESCAPE: .;