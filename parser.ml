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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
    open Secd ;;

    
# 29 "parser.ml"
let yytransl_const = [|
  261 (* PLUS *);
  262 (* TIMES *);
  263 (* LPAREN *);
  264 (* RPAREN *);
  265 (* EOL *);
  266 (* EQUAL *);
  267 (* IF *);
  268 (* THEN *);
  269 (* ELSE *);
  270 (* LAM *);
  271 (* DOT *);
  272 (* LET *);
  273 (* IN *);
  274 (* ASSIGN *);
  275 (* MINUS *);
    0|]

let yytransl_block = [|
  257 (* TRUE *);
  258 (* FALSE *);
  259 (* INT *);
  260 (* VAR *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\006\000\003\000\004\000\004\000\006\000\001\000\
\003\000\001\000\001\000\003\000\003\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\010\000\011\000\008\000\002\000\000\000\000\000\
\000\000\000\000\015\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\001\000\000\000\000\000\004\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\005\000\000\000\006\000\000\000\000\000\000\000\000\000"

let yydgoto = "\002\000\
\011\000\012\000"

let yysindex = "\004\000\
\020\255\000\000\000\000\000\000\000\000\000\000\020\255\020\255\
\005\255\009\255\000\000\253\254\062\255\068\255\010\255\008\255\
\020\255\020\255\020\255\000\000\020\255\020\255\000\000\020\255\
\020\255\020\255\070\255\001\255\078\255\110\255\021\255\085\255\
\000\000\095\255\000\000\020\255\020\255\101\255\021\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\123\255\113\255\000\000\129\255\032\255\000\000\
\000\000\000\000\000\000\000\000\000\000\135\255\047\255"

let yygindex = "\000\000\
\000\000\249\255"

let yytablesize = 152
let yytable = "\013\000\
\014\000\017\000\018\000\019\000\001\000\020\000\021\000\019\000\
\015\000\027\000\028\000\029\000\016\000\030\000\031\000\022\000\
\032\000\033\000\034\000\022\000\003\000\004\000\005\000\006\000\
\025\000\026\000\007\000\019\000\038\000\039\000\008\000\000\000\
\000\000\009\000\000\000\010\000\014\000\014\000\000\000\014\000\
\014\000\014\000\000\000\014\000\014\000\000\000\000\000\000\000\
\014\000\000\000\014\000\003\000\003\000\000\000\003\000\003\000\
\003\000\000\000\003\000\003\000\000\000\000\000\000\000\003\000\
\000\000\003\000\017\000\018\000\019\000\023\000\000\000\021\000\
\017\000\018\000\019\000\018\000\019\000\021\000\000\000\024\000\
\022\000\000\000\017\000\018\000\019\000\035\000\022\000\021\000\
\022\000\017\000\018\000\019\000\000\000\000\000\021\000\000\000\
\022\000\036\000\000\000\017\000\018\000\019\000\000\000\022\000\
\021\000\017\000\018\000\019\000\000\000\000\000\021\000\037\000\
\000\000\022\000\017\000\018\000\019\000\013\000\013\000\022\000\
\013\000\013\000\013\000\000\000\013\000\013\000\000\000\012\000\
\022\000\013\000\012\000\012\000\012\000\000\000\012\000\012\000\
\009\000\009\000\009\000\012\000\009\000\009\000\007\000\007\000\
\000\000\009\000\007\000\007\000\000\000\000\000\000\000\007\000"

let yycheck = "\007\000\
\008\000\005\001\006\001\007\001\001\000\009\001\010\001\007\001\
\004\001\017\000\018\000\019\000\004\001\021\000\022\000\019\001\
\024\000\025\000\026\000\019\001\001\001\002\001\003\001\004\001\
\015\001\018\001\007\001\007\001\036\000\037\000\011\001\255\255\
\255\255\014\001\255\255\016\001\005\001\006\001\255\255\008\001\
\009\001\010\001\255\255\012\001\013\001\255\255\255\255\255\255\
\017\001\255\255\019\001\005\001\006\001\255\255\008\001\009\001\
\010\001\255\255\012\001\013\001\255\255\255\255\255\255\017\001\
\255\255\019\001\005\001\006\001\007\001\008\001\255\255\010\001\
\005\001\006\001\007\001\006\001\007\001\010\001\255\255\012\001\
\019\001\255\255\005\001\006\001\007\001\008\001\019\001\010\001\
\019\001\005\001\006\001\007\001\255\255\255\255\010\001\255\255\
\019\001\013\001\255\255\005\001\006\001\007\001\255\255\019\001\
\010\001\005\001\006\001\007\001\255\255\255\255\010\001\017\001\
\255\255\019\001\005\001\006\001\007\001\005\001\006\001\019\001\
\008\001\009\001\010\001\255\255\012\001\013\001\255\255\005\001\
\019\001\017\001\008\001\009\001\010\001\255\255\012\001\013\001\
\008\001\009\001\010\001\017\001\012\001\013\001\008\001\009\001\
\255\255\017\001\012\001\013\001\255\255\255\255\255\255\017\001"

let yynames_const = "\
  PLUS\000\
  TIMES\000\
  LPAREN\000\
  RPAREN\000\
  EOL\000\
  EQUAL\000\
  IF\000\
  THEN\000\
  ELSE\000\
  LAM\000\
  DOT\000\
  LET\000\
  IN\000\
  ASSIGN\000\
  MINUS\000\
  "

let yynames_block = "\
  TRUE\000\
  FALSE\000\
  INT\000\
  VAR\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 22 "parser.mly"
                            (Expr(_1))
# 165 "parser.ml"
               : Secd.op))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 25 "parser.mly"
                            (Var(_1))
# 172 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 26 "parser.mly"
                                      (Def(_2,_4,_6))
# 181 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 27 "parser.mly"
                             (_2)
# 188 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 28 "parser.mly"
                            (Abs(_2,_4))
# 196 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 29 "parser.mly"
                                        (App(_1,_3))
# 204 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 30 "parser.mly"
                                      (Ifthenelse(_2,_4,_6))
# 213 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 31 "parser.mly"
                  (Const(_1))
# 220 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 32 "parser.mly"
                          (Equal(_1,_3))
# 228 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 33 "parser.mly"
                      (Bool(_1))
# 235 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 34 "parser.mly"
                      (Bool(_1))
# 242 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 35 "parser.mly"
                         (Plus(_1,_3))
# 250 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 36 "parser.mly"
                          (Times(_1,_3))
# 258 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 37 "parser.mly"
                          (Sub(_1,_3))
# 266 "parser.ml"
               : 'expr))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Secd.op)
