(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

(************************ CONSTANTS************************)


(************************ DOM HELPERS ************************)

(* [fail] is a failure/exception handler *)
let fail = fun _ -> assert false

(* [get_element_by_id id] gets a DOM element by its id *)
let get_element_by_id id =
  Js.Opt.get (Html.document##getElementById (js id)) fail

(* [append_text e s] appends string s to element e *)
let append_text e s = Dom.appendChild e (document##createTextNode (js s))

(* [dummy_handler event] handles the key press events registered by the
   canvas window *)
let dummy_handler event =
  Js._true

(************************ GAME LOOP ************************)

let rec game_loop canvas state game_over =
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
  (* add event listeners *)
  let _ = Html.addEventListener
      document Html.Event.keydown (Html.handler dummy_handler) Js._true in
  let _ = Html.addEventListener
      document Html.Event.keyup (Html.handler dummy_handler) Js._true in
  let context = canvas##getContext (Html._2d_) in
  (* testing drawing images *)
  Gui.draw_image_on_context context (js "sprites/right.png") (10., 10.)

let _ = main ()
