build:
	ocamlbuild -use-ocamlfind \
	  -plugin-tag "package(js_of_ocaml.ocamlbuild)" \
		-no-links \
	  main.d.js

clean:
	ocamlbuild -clean
