(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

(* testing *)
type command = {
  mutable up : bool;
  mutable left : bool;
  mutable down : bool;
  mutable right : bool;
}

type location = {
  mutable coord: float * float;
  keypress: command;
}

let loc = {
  coord = (0., 0.);
  keypress = {
    up = false;
    left = false;
    down = false;
    right = false;
  }
}

(************************ CONSTANTS************************)

(************************ DOM HELPERS ************************)

(* [fail] is a failure/exception handler *)
let fail = fun _ -> assert false

(* [get_element_by_id id] gets a DOM element by its id *)
let get_element_by_id id =
  Js.Opt.get (Html.document##getElementById (js id)) fail

(* [append_text e s] appends string s to element e *)
let append_text e s = Dom.appendChild e (document##createTextNode (js s))

(************************ GAME LOOP ************************)

let rec game_loop canvas state command game_over =
  failwith "Unimplemented"

let main () =
  let gui = get_element_by_id "gui" in
  gui##style##cssText <-
    js "font-family: sans-serif";
  let h1 = Html.createH1 document in
  append_text h1 "The Legend of Tomnjam";
  Dom.appendChild gui h1;
  let canvas = Html.createCanvas document in
  canvas##width <- int_of_float Gui.canvas_width;
  canvas##height <- int_of_float Gui.canvas_height;
  Dom.appendChild gui canvas;
  let context = canvas##getContext (Html._2d_) in
  (* add event listeners *)
  let _ = Html.addEventListener
      document Html.Event.keydown (Html.handler Command.keydown)
      Js._true in
  let _ = Html.addEventListener
      document Html.Event.keydown (Html.handler Command.keyup)
      Js._true in
  Gui.draw_image_on_context context (js "sprites/right.png") (50., 50.);
  Gui.draw_image_on_context context (js "sprites/obstacle.png") (100., 50.)


let _ = main ()
