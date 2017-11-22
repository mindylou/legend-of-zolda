open Js_of_ocaml
open Js
open State

let fail = fun _ -> assert false

(* [get_element_by_id id] gets a DOM element by its id *)
let get_element_by_id id =
  Js.Opt.get (Dom_html.document##getElementById (Js.string id)) fail

(* TODO: expand to every object/item/enemy *)
let player_img_assoc dir = function
  | North -> Js.string "sprites/back.png"
  | South -> Js.string "sprites/front.png"
  | East -> Js.string "sprites/right.png"
  | West -> Js.string "sprites/left.png"

(* [move_player p map] moves the player p a given direction on the map. *)
let move_player p d map =
  failwith "Unimplemented"

(* [load_game _] initializes the GUI and starts the game. *)
let load_game _ =
  failwith "Unimplemented"

(* driver for starting the GUI *)
let () =
  Dom_html.window##.onload := Dom_html.handler load_game
