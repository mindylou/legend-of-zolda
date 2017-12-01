(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

(************************ CONSTANTS************************)

(* canvas width and height constants *)
let width = 400
let height = 400

(************************ DOM HELPERS ************************)

(* [fail] is a failure/exception handler *)
let fail = fun _ -> assert false

(* [get_element_by_id id] gets a DOM element by its id *)
let get_element_by_id id =
  Js.Opt.get (Html.document##getElementById (js id)) fail

(* [append_text e s] appends string s to element e *)
let append_text e s = Dom.appendChild e (document##createTextNode (js s))

(************************ GAME LOOP ************************)

(* TODO: add state *)
let game_loop context game_over =
  failwith "Unimplemented"

let main () =
  let gui = get_element_by_id "gui" in
  gui##style##cssText <-
    js "font-family: sans-serif; background-color: #00cc00;";
  let h1 = Html.createH1 document in
  append_text h1 "The Legend of Tomnjam";
  Dom.appendChild gui h1;
  let canvas = Html.createCanvas document in
  canvas##width <- width;
  canvas##height <- height;
  Dom.appendChild gui canvas;
  let context = canvas##getContext (Html._2d_) in
  game_loop context false

let _ = main ()
