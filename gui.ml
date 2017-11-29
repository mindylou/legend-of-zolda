open Graphics_js
open Types

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document
let context_of_canvas canvas = canvas##getContext (Html._2d_)

(* TODO: expand to every object/item/enemy *)
let player_img_assoc dir = function
  | North -> js "sprites/back.png"
  | South -> js "sprites/front.png"
  | East -> js "sprites/right.png"
  | West -> js "sprites/left.png"

(* [is_walkable obj] determines if an object on the map is walkable or not *)
let is_walkable = function
  | Portal _ | Texture -> true
  | Obstacle -> false

(************************ DRAWING ************************)

(* [draw_image_on_canvas context img_src x y] draws the given [img_src]
   string at the x,y coordinate pair on the canvas' [context]. *)
let draw_image_on_canvas context img_src sprite_coord =
  context##drawImage (js img_src) (fst sprite_coord) (snd sprite_coord)

(* [fill_rect context x y w h] fills the given (x,y,w,h) with [color]. *)
let fill_rect context color sprite_coord w h =
  context##fillStyle <- js color;
  context##fillRect (fst sprite_coord) (snd sprite_coord)
    (float_of_int w) (float_of_int h)

(* [draw_sprite context sprite] draws the sprite on the given context. *)
let draw_sprite context sprite =
  if sprite.is_enemy then failwith "TODO"
  else let img_src = player_img_assoc sprite.direction in
    draw_image_on_canvas context img_src sprite.location.coordinate

let draw_kill_count context player_kc =
  failwith "Unimplemented"

let draw_objects context objects_list =
  failwith "Unimplemented"

let win_screen context =
  failwith "Unimplemented"

(************************ ANIMATION ************************)

(* [clear canvas] clears the canvas of all drawing. *)
let clear canvas =
  let ctx = context_of_canvas canvas in
  let width = ctx##width in
  let height = ctx##height in
  ctx##clearRect 0. 0. width height

let update_animations sprite =
  failwith "Unimplemented"

let draw_state state =
  failwith "Unimplemented"
