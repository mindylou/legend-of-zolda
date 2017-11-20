open Js_of_ocaml
open State

(* TODO: expand to every object/item/enemy *)
let player_img_assoc dir = function
  | North -> Js.string "sprites/back.png"
  | South -> Js.string "sprites/front.png"
  | East -> Js.string "sprites/right.png"
  | West -> Js.string "sprites/left.png"

let move_player p map =
  failwith "Unimplemented"

let load_game _ =
  failwith "Unimplemented"

let () =
  Dom_html.onload := Dom_html.handler load_game
