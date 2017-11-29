build:
	ocamlbuild -use-ocamlfind types.cmo state.cmo ai.cmo command.cmo gui.cmo -r
	ocamlbuild -use-ocamlfind \
	  -plugin-tag "package(js_of_ocaml.ocamlbuild)" \
		-no-links \
	  main.d.js

clean:
	ocamlbuild -clean
