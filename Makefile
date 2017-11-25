build:
	ocamlbuild -use-ocamlfind types.cmo state.cmo ai.cmo command.cmo gui.cmo -r
	ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml.graphics -package js_of_ocaml.ppx \
# 	-linkpkg -o gui.byte gui.ml
	js_of_ocaml +graphics.js gui.byte
	./gui.byte

clean: 
	ocamlbuild -clean


