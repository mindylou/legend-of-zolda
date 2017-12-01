open Types
open Yojson.Basic.Util

let sprite_of_json =
  (* {
    id = j |> member "id" |> to_int;
    name = (if id = 0 then Player else Enemy);
    is_enemy = j |> member "is_enemy" |> to_bool;
    size = j |> member "size" |> ;
    speed: int;
    location: location;
    health: int;
    kill_count: int;
    direction: direction;
    moves: move list;
    moving: bool;
     } *) failwith "todo"
let init_state j =
  failwith "todo"
let distance_btwn (x1,y1) (x2,y2) =
  sqrt ((x1 -. x2) ** 2. +. (y1 -. y2) ** 2.)

let get_sprite_list st =
  st.all_sprites

let rec get_sprite (id: int) lst =
  match lst with
  | [] -> failwith "invalid sprite id [GET]"
  | h::t ->
    if h.id = id then h
    else get_sprite id t

let get_player_location st =
  (get_sprite 0 st.all_sprites).location

let init_state = ()

(* helper function for all_sprite_locations
   requires: lst and ret are lists,
   returns: assoc list of name to location for each sprite *)
let rec location_helper (lst: sprite list) ret =
  match lst with
  | [] -> ret
  | sprite::t -> (sprite.name, sprite.location)::ret

let all_sprite_locations st =
  let all_sprites = st.all_sprites in
  location_helper all_sprites []

let current_room_id st =
  st.current_room_id

let get_health id st =
  (get_sprite id st.all_sprites).health

let get_location id st =
  (get_sprite id st.all_sprites).location

(* helper function to get direction of sprite
    requires: id is a sprite id, lst is a list of sprites *)
let get_sprite_direction id st =
  (get_sprite id st.all_sprites).direction

(* helper function to check of sprite is on a square *
   requires: all_sprites is the lsit of all_sprites, loc is alocation *)
let rec sprite_on_square (all_sprites: sprite list) loc =
  match all_sprites with
  | [] -> true
  | h::t ->
      (if h.location.coordinate = loc then false
      else sprite_on_square t loc)


let valid_move st loc =
  let not_sprite = sprite_on_square st.all_sprites loc in
  not_sprite

let rec all_but_target (all_sprites: sprite list) sprite_id ret =
  match all_sprites with
  | [] -> ret
  | sprite::t ->
    if not (sprite.name  = sprite_id) then all_but_target t sprite_id (sprite::ret)
    else all_but_target t sprite_id ret

let exec_move st (target_sprite: sprite) =
  let all_but_one = all_but_target st.all_sprites target_sprite.name [] in
  let updated_sprites = target_sprite::all_but_one in
  {st with all_sprites = updated_sprites}
let process_move dir st sprite_id =
  let target_sprite = get_sprite sprite_id st.all_sprites in
  let current_loc = (get_location sprite_id st).coordinate in
  let target_loc =
    match dir with
    | West -> ((fst current_loc) -. 0.1, snd current_loc)
    | East -> ((fst current_loc) +. 0.1, snd current_loc)
    | North -> (fst current_loc, (snd current_loc +. 0.1))
    | South -> (fst current_loc, (snd current_loc -. 0.1)) in
  if valid_move st target_loc then
    let new_loc = {target_sprite.location with coordinate = target_loc} in
    let updated_sprite = {target_sprite with location = new_loc} in
    exec_move st updated_sprite
  else st

let move_helper dir st sprite_id =
  process_move dir st sprite_id
let rec all_sprites_in_room (all_sprites: sprite list) (room_id: string) ret =
  match all_sprites with
  | [] -> ret
  | sprite::t ->
    if sprite.location.room = room_id then all_sprites_in_room t room_id (sprite::ret)
    else all_sprites_in_room t room_id ret

let do' cmd st =
  let target_sprites = all_sprites_in_room st.all_sprites st.current_room_id [] in
  let player_sprites = List.filter (fun (sprite: sprite) ->
      match sprite.name with
      | Player -> true
      | Enemy _  -> false) target_sprites in
  let enemy_sprites = List.filter (fun (sprite: sprite) ->
      match sprite.name with
      | Player -> false
      | Enemy _  -> true) target_sprites in
  st
