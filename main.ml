open Secd ;;
open Printf;;

        let main =
          try
            let lexbuf = Lexing.from_channel stdin in
          while true do
              try
                let result = Parser.main Start.count lexbuf in
                match result with Expr(expp) -> print_string(string_of_exp expp);print_newline();flush stdout;
                print_string("KRIVINE :-> "^string_of_clos (krivine (Clo(expp,[])) [] ) ^ "\n"); flush stdout ;
                print_string("SECD :-> "^string_of_clos (secd [] [] [result] []) ^ "\n"); flush stdout ; ()
              with
              | Secd.Bad -> print_string("Not Possible\n") ; flush stdout ; ()
            done
          with Start.Eof ->
            exit 0
          ;;
