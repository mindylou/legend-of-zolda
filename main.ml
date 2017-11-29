
(* [js_of_ocaml standard declarations]*)
module Html = Dom_html
let js = Js.string
let document = Html.document

let width = 400
let height = 400

(* [fail] is a failure/exception handler *)
let fail = fun _ -> assert false

(* [get_element_by_id id] gets a DOM element by its id *)
let get_element_by_id id =
  Js.Opt.get (Dom_html.document##getElementById (Js.string id)) fail

(* [append_text e s] appends string s to element e *)
let append_text e s = Dom.appendChild e (document##createTextNode (Js.string s))

let game_loop context game_over =
  failwith "Unimplemented"

let main () =
  let gui = get_element_by_id "gui" in
  gui##style##cssText <-
    Js.string "font-family: sans-serif; background-color: #00cc00;";
  let h1 = Dom_html.createH1 document in
  append_text h1 "The Legend of Tomnjam";
  Dom.appendChild gui h1;
  let canvas = Html.createCanvas document in
  canvas##width <- width;
  canvas##height <- height;
  Dom.appendChild gui canvas;
  let context = canvas##getContext (Html._2d_) in
  game_loop context false

let _ = main ()
