open Types

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

(************************ CONSTANTS************************)
(* testing objects *)
let test_loc1 = { coordinate = (0., 0.); room = "test" }
let test_loc2 = { coordinate = (0., 26.); room = "test" }
let test_loc3 = { coordinate = (26., 26.); room = "test" }

let test_obj1 = Texture test_loc1
let test_obj2 = Obstacle test_loc2
let test_obj3 = Obstacle test_loc3
let test_lst = [test_obj1; test_obj2; test_obj3]

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
  append_text h1 "The Legend of Tomnjam";
  Dom.appendChild gui h1;
  let canvas = Html.createCanvas document in
  canvas##width <- int_of_float Gui.canvas_width;
  canvas##height <- int_of_float Gui.canvas_height;
  Dom.appendChild gui canvas;
  let context = canvas##getContext (Html._2d_) in
  (* let start_state = Game.json_to_init_state "start.json" in
  Gui.draw_state context start_state; *)
  (* add event listeners *)
  let _ = Html.addEventListener
      document Html.Event.keydown (Html.handler Game.keydown)
      Js._true in
  let _ = Html.addEventListener
      document Html.Event.keydown (Html.handler Game.keyup)
      Js._true in

  Game.game_loop context false

let _ = main ()
