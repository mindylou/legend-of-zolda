open Types

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

(************************ DOM HELPERS ************************)

(* [fail] is a failure/exception handler *)
let fail = fun _ -> assert false

(* [get_element_by_id id] gets a DOM element by its id *)
let get_element_by_id id =
  Js.Opt.get (Html.document##getElementById (js id)) fail

(* [append_text e s] appends string s to element e *)
let append_text e s = Dom.appendChild e (document##createTextNode (js s))

(************************ START GAME ************************)

let main () =
  let gui = get_element_by_id "gui" in
  gui##style##cssText <- js "font-family:Triforce";
  let h1 = Html.createH1 document in
  let h2 = Html.createH2 document in
  let audio = Html.createAudio document in
  audio##src <- js "zolda.mp3";
  audio##play ();
  append_text h1 "The Legend of Zolda";
  append_text h2 "You are Lonk. Save Zolda!!";
  Dom.appendChild gui h1;
  Dom.appendChild gui h2;
  let canvas = Html.createCanvas document in
  canvas##width <- int_of_float Gui.canvas_width;
  canvas##height <- int_of_float Gui.canvas_height;
  Dom.appendChild gui canvas;
  let context = canvas##getContext (Html._2d_) in
  (* add event listeners *)
  let _ = Html.addEventListener
      document Html.Event.keydown (Html.handler Game.keydown)
      Js._true in
  let _ = Html.addEventListener
      document Html.Event.keydown (Html.handler Game.keyup)
      Js._true in
  Game.game_loop context false

let _ = main ()
