build:
	ocamlbuild -use-ocamlfind state.cmo gui.cmo
	ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml.ppx -linkpkg -o gui.byte gui.ml
	js_of_ocaml gui.byte
	./gui.byte

clean: 
	ocamlbuild -clean


