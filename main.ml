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

let keydown event =
  match event##keyCode with
    | 87 -> loc.keypress.up <- true (* w *)
    | 65 -> loc.keypress.left <- true (* a *)
    | 83 -> loc.keypress.down <- true (* s *)
    | 68 -> loc.keypress.right <- true (* d *)
    | _ -> () (* other *)

let keyup event =
  match event##keyCode with
    | 87 -> loc.keypress.up <- false (* w *)
    | 65 -> loc.keypress.left <- false (* a *)
    | 83 -> loc.keypress.down <- false (* s *)
    | 68 -> loc.keypress.right <- false (* d *)
    | _ -> () (* other *)

let match_key_move loc =
  if loc.keypress.up then
    loc.coord <- (fst loc.coord, snd loc.coord -. 1.)
  else if loc.keypress.left then
    loc.coord <- (fst loc.coord -. 1., snd loc.coord)
  else if loc.keypress.down then
    loc.coord <- (fst loc.coord, snd loc.coord +. 1.)
  else
    loc.coord <- (fst loc.coord +. 1., snd loc.coord)

let rec game_loop canvas state command game_over =
  failwith "Unimplemented"

let rec loop context =
  Gui.clear context;
  Gui.draw_image_on_context context (js "sprites/front.png")
    (match_key_move loc.coord)

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
  (* add event listeners *)
  let _ = Html.addEventListener
      document Html.Event.keydown (Html.handler (fun ev -> keydown ev))
      Js._true in
  let _ = Html.addEventListener
      document Html.Event.keyup (Html.handler (fun ev -> keyup ev))
      Js._true in

  (* testing drawing images *)
  Gui.draw_image_on_context context (js "sprites/right.png") (10., 10.)

let _ = main ()
