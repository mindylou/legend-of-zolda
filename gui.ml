open Js_of_ocaml
(* open State *)

let document = Dom_html.window##.document

let append_text e s = Dom.appendChild e (document##createTextNode (Js.string s))

(* [fail] is a failure/exception handler *)
let fail = fun _ -> assert false

(* [get_element_by_id id] gets a DOM element by its id *)
let get_element_by_id id =
  Js.Opt.get (Dom_html.document##getElementById (Js.string id)) fail

(* [get_canvas element] gets the DOM canvas for the game. *)
let get_canvas_element id =
  Js.Opt.get
    (Js.Opt.bind (Dom_html.document##getElementById (Js.string id))
       Dom_html.CoerceTo.canvas) fail

(* TODO: expand to every object/item/enemy *)
(* let player_img_assoc dir = function
  | North -> Js.string "sprites/back.png"
  | South -> Js.string "sprites/front.png"
  | East -> Js.string "sprites/right.png"
  | West -> Js.string "sprites/left.png"
 *)
(* [is_walkable obj] determines if an object on the map is walkable or not *)
(* let is_walkable = function
  | Portal _ | Texture -> true
  | Obstacle -> false *)

(* [set_cell state x y obj] sets the state's map coordinates to
   the object, and updates the image associated with that object *)
let set_cell state x y obj =
  failwith "Unimplemented"

(* [move_player p map] moves the player p a given direction on the map. *)
(* let move_player p d state =
  let (x, y) = state.player_location.coordinate in
  let potential_move =
    match d with
    | North -> (x, y+.1.)
    | East -> (x+.1., y)
    | South -> (x, y-.1.)
    | West -> (x-.1., y)
  in failwith "Unimplemented" *)
(* TODO: need object locations to then pattern match and update *)

(* NOTE: this isn't working lol *)
(* [draw_image_on_canvas context img_src x y] draws the given image source
   string at the x y coordinate on the canvas' context. *)
let draw_image_on_canvas context img_src x y =
  context##drawImage (Js.string img_src) (float_of_int x) (float_of_int y); ()

(* [fill_rect context x y w h] fills the *)
let fill_rect context x y w h =
  context##fillRect (float_of_int x) (float_of_int y) (float_of_int w) (float_of_int h); ()

(* [load_game _] initializes the GUI and starts the game. *)
let load_game _ =
  let body = get_element_by_id "gui" in
  body##.style##.cssText :=
    Js.string "font-family: sans-serif; background-color: #00cc00;";
  let h1 = Dom_html.createH1 document in
  append_text h1 "The Legend of Tomnjam";
  Dom.appendChild body h1;
  let board_div = Dom_html.createDiv document in
  let div = Dom_html.createDiv document in
  let canvas = get_canvas_element "canvas" in
  let context = canvas##getContext (Dom_html._2d_) in
  fill_rect context 100 100 100 100;
  (* let height = canvas##.height in
     let width = canvas##.width in *)
  Dom.appendChild body canvas;
  Dom.appendChild div board_div;
  Dom.appendChild body div; Js._false


(* driver for starting the GUI *)
let () =
  Dom_html.window##.onload := Dom_html.handler load_game; ()
