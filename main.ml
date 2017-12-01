open State
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
let x = 10.
let y = 10.

let keydown event context x y =
  let () = match event##keyCode with
    | 87 -> Gui.clear context; (* w *)
      Gui.draw_image_on_context context (js "sprites/back.png") (x, y -. 1.)
    | 65 -> Gui.clear context; (* a *)
      Gui.draw_image_on_context context (js "sprites/left.png") (x -. 1., y)
    | 83 -> Gui.clear context; (* s *)
      Gui.draw_image_on_context context (js "sprites/front.png") (x, y +. 1.)
    | 68 -> Gui.clear context; (* d *)
      Gui.draw_image_on_context context (js "sprites/right.png") (x +. 1., y)
    | _ -> () (* other *)
  in Js._true

let rec game_loop canvas state command game_over =
  failwith "Unimplemented"

let main () =
  let gui = get_element_by_id "gui" in
  gui##style##cssText <-
    js "font-family: sans-serif; background-color: #00cc00;";
  let h1 = Html.createH1 document in
  append_text h1 "The Legend of Tomnjam";
  Dom.appendChild gui h1;
  let canvas = Html.createCanvas document in
  canvas##width <- int_of_float Gui.canvas_width;
  canvas##height <- int_of_float Gui.canvas_width;
  Dom.appendChild gui canvas;
  let context = canvas##getContext (Html._2d_) in
  let start_state = init_state (Yojson.Basic.from_file "start.json") in
  Gui.draw_state context start_state
  (* add event listeners *)
  let _ = Html.addEventListener
      document Html.Event.keydown (Html.handler (fun ev -> keydown ev context x y))
      Js._true in
  Gui.draw_image_on_context context (js "sprites/right.png") (x, y)

let _ = main ()
