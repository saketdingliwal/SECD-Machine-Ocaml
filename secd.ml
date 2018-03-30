exception Bad;;
exception Unbound_Val_For_variale;;
type exp = Sub of (exp*exp) | Def of (string*exp*exp) |Equal of (exp*exp) | Ifthenelse of (exp*exp*exp) | Bool of bool| Plus of (exp*exp)| Times of (exp*exp) | Const of int |Var of string | Abs of (string * exp) | App of (exp * exp);;

type env = (string * closure) list
and
closure = Clo of (exp * env)
;;

type op = Expr of exp | Apply | Plus | Times | If | Equal | Subt;;
type oplist = op list ;;


let rec string_of_exp expr = match expr with
Const(i1) -> string_of_int i1
| Bool(b) -> if b then "true" else "false"
| Abs(str,e1) -> ("\\" ^ str ^ ". ( " ^ string_of_exp e1 ^ " )")
| Var(x) -> x
| App(e1,e2) -> string_of_exp e1 ^ "( " ^ string_of_exp e2 ^ " )"
| Plus(e1,e2) -> string_of_exp e1 ^ " + " ^ string_of_exp e2
| Sub(e1,e2) -> string_of_exp e1 ^ " - " ^ string_of_exp e2
| Times(e1,e2) -> string_of_exp e1 ^ " * " ^ string_of_exp e2
| Equal(e1,e2) -> string_of_exp e1 ^ " = " ^ string_of_exp e2
| Ifthenelse(e1,e2,e3) -> "if " ^ string_of_exp e1 ^ " then " ^ string_of_exp e2 ^ " else " ^ string_of_exp e3
| Def(bound_var,e1,e2) -> "let " ^ bound_var ^ ":= " ^ string_of_exp e1 ^ " in " ^ string_of_exp e2
;;



let rec search_in_env var_name gamma = match gamma with
[] -> print_string("Unbound_Val_For_variale " ^ var_name);print_newline();raise Bad
| hd :: tl -> if fst hd = var_name then (snd hd) else search_in_env var_name tl
;;


let frs triplet = match triplet with
(x,y,z) -> x
;;
let scd triplet = match triplet with
(x,y,z) -> y
;;
let thd triplet = match triplet with
(x,y,z) -> z
;;

let firstelem li = match li with
hd :: tl -> hd
| _ -> raise Bad
;;

let secelem li = match li with
hd1 :: hd2 :: tl -> hd2
| _ -> raise Bad
;;

let secrem li = match li with
hd1 :: hd2 :: tl -> tl
| _ -> raise Bad
;;

let firstrem li = match li with
hd1 :: tl -> tl
| _ -> raise Bad
;;


let rec secd stack gamma oplist dump = match oplist with
[] -> ( match dump with
      [] -> ( match stack with
            [] -> raise Bad
            | hd :: tl -> hd
            )
      | hd :: tl -> ( match stack with
                      [] -> secd (frs hd) (scd hd) (thd hd) tl
                      | hd_s :: tl_s ->   secd (hd_s :: frs hd) (scd hd) (thd hd) tl
                    )
      )
| hd :: tl -> ( match hd with
              Expr(expr) -> ( match expr with
                            Const(i) -> secd (Clo(expr,[]) :: stack) gamma tl dump
                            | Bool(b) -> secd (Clo(expr,[]) :: stack) gamma tl dump
                            | Ifthenelse(e1,e2,e3) -> secd stack gamma ([Expr(e1)] @ [If] @ [Expr(e2)] @ [Expr(e3)] @ tl) dump
                            | Plus(e1,e2) -> secd stack gamma ([Expr(e1)] @ [Expr(e2)] @ [Plus] @ tl) dump
                            | Times(e1,e2) -> secd stack gamma ([Expr(e1)] @ [Expr(e2)] @ [Times] @ tl) dump
                            | Var(var_name) -> (let dff = search_in_env var_name gamma in
                                              match dff with Clo(expp,env) ->
                                              ( match expp with
                                              Abs(_,_) -> secd ( (Clo(expp,(var_name,dff)::env)) :: stack) gamma tl dump
                                              | _ -> secd  (dff :: stack) gamma tl dump
                                              )
                                              )
                            | Abs(bound_var,fnexp) -> secd (Clo(expr,gamma) :: stack) gamma tl dump
                            | App(e1,e2) -> secd stack gamma ([Expr(e1)] @ [Expr(e2)] @ [Apply] @ tl) dump
                            | Equal(e1,e2) -> secd stack gamma ( [Expr(e1)] @ [Expr(e2)] @ [Equal] @ tl) dump
                            | Sub(e1,e2) -> secd stack gamma ([Expr(e1)] @ [Expr(e2)] @ [Subt] @ tl) dump
                            | Def(bound_var,e1,e2) -> secd stack gamma ([Expr(Abs(bound_var,e2))] @ [Expr(e1)] @ [Apply] @ tl ) dump
                           )
              | Apply -> (  match stack with
                            hd1 :: hd2 :: tl1 -> ( match hd2 with Clo(expr,gammadash) -> match expr with
                                                  Abs(var,expr) -> secd [] ((var,hd1)::gammadash) [Expr(expr)] ((tl1,gamma,tl)::dump)
                                                  | _ -> print_string("Type Assumption Failure ");print_newline();raise Bad
                                                 )
                            | _ -> raise Bad
                           )
              | Plus -> ( match (firstelem stack,secelem stack) with
                        (Clo(Const(i1),_),Clo(Const(i2),_)) -> secd ((Clo(Const(i1+i2),[]))::(secrem stack)) gamma tl dump
                        | _ -> print_string("Type Assumption Failure ");print_newline();raise Bad
                        )
              | Subt -> ( match (firstelem stack,secelem stack) with
                        (Clo(Const(i1),_),Clo(Const(i2),_)) -> secd ((Clo(Const(i2-i1),[]))::(secrem stack)) gamma tl dump
                        | _ -> print_string("Type Assumption Failure ");print_newline();raise Bad
                        )
              | Times-> ( match (firstelem stack,secelem stack) with
                        (Clo(Const(i1),_),Clo(Const(i2),_)) -> secd ((Clo(Const(i1*i2),[]))::(secrem stack)) gamma tl dump
                        | _ -> print_string("Type Assumption Failure ");print_newline();raise Bad
                        )
              | If -> ( match firstelem stack with
                        Clo(Bool(b),_) -> ( if b then secd stack gamma ((firstelem tl) :: (secrem tl)) dump
                                          else secd stack gamma ((secelem tl) :: (secrem tl)) dump
                                          )
                        | _ ->print_string("Type Assumption Failure ");print_newline(); raise Bad
                      )

              | Equal -> ( match (firstelem stack,secelem stack )with
                           (Clo(Const(i1),_),Clo(Const(i2),_)) -> ( if i1 = i2 then secd ( (Clo(Bool(true),[])) :: firstrem stack ) gamma tl dump
                                                  else secd ( (Clo(Bool(false),[])) :: firstrem stack ) gamma tl dump
                                               )
                           | _ -> print_string("Type Assumption Failure ");print_newline();raise Bad
                         )
              )
;;

let expp1 = App(Abs("x",Times(Var("x"),Const(2))),Const(3));;
let expp2 = App(Abs("x",Times(Var("x"),Var("x"))),expp1);;
let expp3 = App(Abs("x",Plus(Var("x"),Const(10))),expp2);;
let expp :exp = Plus(expp2,expp3);;
let expp4 = App(Abs("x",App(Var("x"),expp)),Abs("y",Var("y"))) ;;
let expp5 = Ifthenelse(Equal(expp1,expp2),expp4,expp1);;

let xp = App(Abs("x",Var("x")),Var("y")) ;;


let rec krivine clos stack = ( match clos with Clo(expr,gamma) -> (match expr with
                              Var(var_name) -> ( let dff = search_in_env var_name gamma in
                                                match dff with Clo(expp,env) ->  match expp with
                                                Abs(_,_) -> krivine (Clo(expp,(var_name,dff)::env)) stack
                                                |_ -> krivine dff stack
                                                )
                              | Const(i) -> clos
                              | Bool(b) -> clos
                              | Ifthenelse(e1,e2,e3) -> ( let cl1 = krivine (Clo(e1,gamma)) stack in
                                                         match cl1 with
                                                         Clo(Bool(b),_) -> ( if b then krivine (Clo(e2,gamma)) stack
                                                                             else krivine (Clo(e3,gamma)) stack
                                                                           )
                                                         | _ -> print_string("Type Assumption Failure ");print_newline();raise Bad
                                                        )
                              | Equal(e1,e2) -> ( let cl1 = krivine (Clo(e1,gamma)) stack in
                                                    let cl2 = krivine (Clo(e2,gamma)) stack in
                                                match (cl1,cl2) with
                                                (Clo(Const(i1),_),Clo(Const(i2),_)) -> ( if i1=i2 then Clo(Bool(true),[])
                                                                      else Clo(Bool(false),[])
                                                                    )
                                                | _ ->print_string("Type Assumption Failure ");print_newline(); raise Bad
                                              )
                              | Plus(e1,e2) -> ( let cl1 = krivine (Clo(e1,gamma)) stack in
                                                  let cl2 = krivine (Clo(e2,gamma)) stack in
                                                match (cl1,cl2) with
                                                (Clo(Const(i1),_),Clo(Const(i2),_)) -> Clo(Const(i1+i2),[])
                                                | _ -> print_string("Type Assumption Failure ");print_newline();raise Bad)
                              | Sub(e1,e2) -> ( let cl1 = krivine (Clo(e1,gamma)) stack in
                                                  let cl2 = krivine (Clo(e2,gamma)) stack in
                                                match (cl1,cl2) with
                                                (Clo(Const(i1),_),Clo(Const(i2),_)) -> Clo(Const(i1-i2),[])
                                                | _ -> print_string("Type Assumption Failure ");print_newline();raise Bad)
                              | Times(e1,e2) -> (  let cl1 = krivine (Clo(e1,gamma)) stack in
                                                  let cl2 = krivine (Clo(e2,gamma)) stack in
                                                match (cl1,cl2) with
                                                (Clo(Const(i1),_),Clo(Const(i2),_)) -> Clo(Const(i1*i2),[])
                                                | _ -> print_string("Type Assumption Failure ");print_newline();raise Bad )
                              | Abs(bound,expp) -> (match stack with
                                                    [] -> clos
                                                    | hd :: tl -> krivine (Clo(expp,((bound,hd)::gamma))) tl
                                                    )
                              | App(e1,e2) ->krivine  (Clo(e1,gamma)) (Clo(e2,gamma)::stack)
                              | Def(bound,e1,e2) -> krivine (Clo(Abs(bound,e2),gamma)) (Clo(e1,gamma)::stack)
                                                                  )
                              )
;;



let rec string_of_clos closs = match closs with Clo(expr,gamma) ->
string_of_exp expr
;;
