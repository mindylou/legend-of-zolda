open Graphics_js
open Types

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document
let context_of_canvas canvas = canvas##getContext (Html._2d_)

(* TODO: expand to every object/item/enemy *)
let player_img_assoc = function
  | North -> js "sprites/back.png"
  | South -> js "sprites/front.png"
  | East -> js "sprites/right.png"
  | West -> js "sprites/left.png"

let enemy_color_assoc = function
  | Blind -> "black"
  | Coop -> "blue"
  | Boss -> "red"

let obj_color_assoc = function
  | Portal p -> "yellow"
  | Texture -> "green"
  | Obstacle -> "brown"

(* [is_walkable obj] determines if an object on the map is walkable or not *)
let is_walkable = function
  | Portal _ | Texture -> true
  | Obstacle -> false

(************************ DRAWING ************************)

(* [draw_image_on_canvas context img_src x y] draws the given [img_src]
   string at the x,y coordinate pair on the canvas' [context]. *)
let draw_image_on_canvas context img_src sprite_coord =
  context##drawImage img_src (fst sprite_coord) (snd sprite_coord)

(* [fill_rect context x y w h] fills the given (x,y,w,h) with [color]. *)
let fill_rect context color coord w h =
  context##fillStyle <- (js color);
  context##fillRect (fst coord) (snd coord)
    (float_of_int w) (float_of_int h)

(* [draw_sprite context sprite] draws the sprite on the given context. *)
let draw_sprite context sprite =
  match sprite.name with
  | Enemy e -> fill_rect context
                 (enemy_color_assoc e)
                 sprite.location.coordinate
                 sprite.size
                 sprite.size
  | Player -> let img_src = player_img_assoc sprite.direction in
    draw_image_on_canvas context img_src sprite.location.coordinate

let draw_kill_count context player =
  failwith "Unimplemented"

(* [draw_objects context objects_list] draws all of the basic map objects.
   NOTE: currently objects are 50x50. *)
let draw_objects context objects_list =
  List.map (fun obj ->
      fill_rect context (obj_color_assoc obj.obj_type)
        obj.location.coordinate 50 50)
    objects_list
  |> ignore

let win_screen context =
  context##fillStyle <- js "black";
  context##fillRect 0. 0. 400. 400.;
  context##fillStyle <- js "white";
  context##fillText (js "YOU WIN!") 200. 200.

let lose_screen context =
  context##fillStyle <- js "black";
  context##fillRect 0. 0. 400. 400.;
  context##fillStyle <- js "white";
  context##fillText (js "GAME OVER.") 200. 200.

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
