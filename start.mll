{
        open Parser        (* The type token is defined in parser.mli *)
        exception Eof
        exception Invalid
}
        rule count = parse
            [' ' '\t']     { count lexbuf }     (* skip blanks *)
          | ['\n' ]        { EOL }
          | "let"          {LET}
          | "in"           {IN}
          | ":="          {ASSIGN}
          | "if"          {IF}
          | "then"        {THEN}
          | "else"        {ELSE}
          | ['0'-'9']+ as lxm { INT(int_of_string lxm) }
          | "\\"  {LAM}
          | "."   {DOT}
          | "T"       {TRUE(true)}
          | "F"       {FALSE(false)}
          | '+'            { PLUS }
          | "-"             {MINUS}
          | '*'            { TIMES }
          | '('            { LPAREN }
          | ')'            { RPAREN }
          | '='            { EQUAL}
          | ['a'-'z'](['a'-'z']|['A'-'Z']|['0'-'9']|[ '_' '\''])* as lxm { VAR(lxm) }
          | _   { raise Invalid }
          | eof            { raise Eof }
