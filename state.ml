open Yojson.Basic.Util
open Types


let lst_to_tuple lst =
  match lst with
  | [] -> raise (Failure "Invalid tuple")
  | [h; x] -> (float h, float x)
  | _ -> raise (Failure "More than two Int")

let loc_of_json j =
  let coordinate_tup = j |> member "coordinate" |> to_list |> filter_int in
  {
    coordinate = lst_to_tuple coordinate_tup;
    room = j |> member "room" |> to_string;
  }

let moves_of_json j =
  let move_lst = j |> member "moves" in
  {
    id = move_lst |> member "id" |> to_string;
    unlocked = move_lst |> member "unlocked" |> to_bool;
    frame = move_lst |> member "frames" |> to_int;
  }

let dir_of_json j =
  let d = j |> member "direction" |> to_string in
  match d with
  | "North" -> North
  | "West" -> West
  | "East" -> East
  | "South" -> South
  | _ -> raise (Failure "invalid location")

let portal_of_json j =
  {
    location = j |> member "from" |> loc_of_json;
    teleport_to = j |> member "to" |> loc_of_json;
  }

let sprite_of_json j =
  let size_tup = j |> member "size" |> to_list |> filter_int in
  let sprite_id = j |> member "id" |> to_int in
  {
    id = sprite_id;
    name = (if sprite_id = 0 then Player else Enemy Blind);
    is_enemy = j |> member "is_enemy" |> to_bool;
    size = lst_to_tuple size_tup;
    speed = j |> member "speed" |> to_int;
    location = j |> loc_of_json;
    health = (j |> member "id" |> to_float, j |> member "id" |> to_float);
    kill_count = j |> member "id" |> to_int;
    direction = j |> dir_of_json;
    moves = j |> member "moves" |> to_list |> List.map moves_of_json;
    moving = j |> member "moving" |> to_bool;
  }

let obj_of_json j =
  let obj_type = j |> member "type" |> to_string in
  match obj_type with
  | "End" -> End (loc_of_json j)
  | "Obstacle" -> Obstacle (loc_of_json j)
  | "Texture" -> Texture (loc_of_json j)
  | "Portal" -> Portal (portal_of_json j)
  | _ -> raise (Failure "Invalid object in Json")

let room_of_json j =
  {
    room_id = j |> member "id" |> to_string;
    width = j |> member "width" |> to_float;
    height = j |> member "height" |> to_float;
    obj_lst = j |> member "objects" |> to_list |> List.map obj_of_json;
  }

let init_state j =
  {
    all_sprites = j |> member "sprites"
                  |> to_list |> List.map sprite_of_json;
    has_won = j |> member "has_won" |> to_bool;
    all_rooms = j |> member "rooms" |> to_list |> List.map room_of_json;
    current_room_id = j |> member "curr_room" |> to_string;
  }

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
