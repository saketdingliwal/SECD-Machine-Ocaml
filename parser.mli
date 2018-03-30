type token =
  | TRUE of (bool)
  | FALSE of (bool)
  | INT of (int)
  | VAR of (string)
  | PLUS
  | TIMES
  | LPAREN
  | RPAREN
  | EOL
  | EQUAL
  | IF
  | THEN
  | ELSE
  | LAM
  | DOT
  | LET
  | IN
  | ASSIGN
  | MINUS

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Secd.op
