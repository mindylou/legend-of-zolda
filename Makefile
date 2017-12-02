build:
	ocamlbuild -use-ocamlfind -pkgs yojson helper.cmo types.cmo state.cmo ai.cmo command.cmo gui.cmo -r
	ocamlbuild -use-ocamlfind \
	  -plugin-tag "package(js_of_ocaml.ocamlbuild)" \
		-no-links \
	  main.d.js

clean:
	ocamlbuild -clean

test:
	ocamlbuild -use-ocamlfind -pkg yojson helper.cmo types.cmo state.cmo ai.cmo command.cmo gui.cmo -r
	ocamlbuild -use-ocamlfind -pkg oUnit test_state.cmo -r
	ocamlbuild -use-ocamlfind test_state.byte && ./test_state.byte
