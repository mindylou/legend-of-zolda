open Types

let distance_btwn (x1,y1) (x2,y2) =
  sqrt ((x1 -. x2) ** 2. +. (y1 -. y2) ** 2.)

let get_sprite_list st = 
  st.all_sprites

let rec get_sprite id lst = 
  match lst with
  | [] -> failwith "invalid sprite id [GET]"
  | h::t -> 
    if h.name = id then h
    else get_sprite id t

let get_player_location st = 
  (get_sprite "player" st.all_sprites).location

let init_state = ()

(* helper function for all_sprite_locations
   requires: lst and ret are lists, 
   returns: assoc list of name to location for each sprite *)
let rec location_helper lst ret = 
  match lst with 
  | [] -> ret
  | sprite::t -> (sprite.name, sprite.location)::ret

let all_sprite_locations st = 
  let all_sprites = st.all_sprites in 
  location_helper all_sprites []

let current_room_id st = 
  st.current_room_id

let do' cmd st = 
  failwith "todo"

let get_health id st = 
  (get_sprite id st.all_sprites).health

let get_location id st = 
  (get_sprite id st.all_sprites).location

(* helper function to get direction of sprite
   requires: id is a sprite id, lst is a list of sprites *)
let get_sprite_direction id st = 
  (get_sprite id st.all_sprites).direction

let type_of_square loc st = 
  failwith "todo"