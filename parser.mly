   %{
    open Secd ;;

    %}

        %token <bool> TRUE FALSE
        %token <int> INT
        %token <string> VAR
        %token PLUS TIMES LPAREN RPAREN EOL EQUAL IF THEN ELSE LAM DOT LET IN ASSIGN MINUS
        %start main
        %left EOL
        %left ELSE
        %left EQUAL
        %left PLUS
        %left TIMES
        %left MINUS
        %left IN
        %left LPAREN RPAREN
        %left DOT
        %type <Secd.op> main
        %%
        main : expr EOL     {Expr($1)}
        ;
        expr:
        VAR                 {Var($1)}
        | LET VAR ASSIGN expr IN expr {Def($2,$4,$6)}
        | LPAREN expr RPAREN {$2}
        | LAM VAR DOT expr  {Abs($2,$4)}
        | expr LPAREN expr RPAREN       {App($1,$3)}
        | IF expr THEN expr ELSE expr {Ifthenelse($2,$4,$6)}
        | INT     {Const($1)}
        | expr EQUAL expr {Equal($1,$3)}
        | TRUE        {Bool($1)}
        | FALSE       {Bool($1)}
        | expr PLUS expr {Plus($1,$3)}
        | expr TIMES expr {Times($1,$3)}
        | expr MINUS expr {Sub($1,$3)}
        ;
