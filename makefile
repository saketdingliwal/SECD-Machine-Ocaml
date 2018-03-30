make:
	ocamlc -c secd.ml
	ocamlyacc parser.mly
	ocamlc -c parser.mli
	ocamllex start.mll
	ocamlc -c parser.ml
	ocamlc -c start.ml
	ocamlc -c main.ml
	ocamlc secd.cmo start.cmo parser.cmo main.cmo
