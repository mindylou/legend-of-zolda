open Yojson.Basic.Util
open Types
open Command

let object_size = (26, 26)

(* let lst_to_tuple lst =
  if List.length lst = 2 then
    (float (List.nth lst 0), float (List.nth lst 1))
  else raise (Failure "invalid lst to tuple")

let loc_of_json j =
  let coordinate_tup = j |> member "coordinate" |> to_list |> filter_int in
  {
    coordinate = lst_to_tuple coordinate_tup;
    room = j |> member "room" |> to_string;
  }

let moves_of_json j =
  {
    id = j |> member "id" |> to_string;
    unlocked = j |> member "unlocked" |> to_bool;
    frame = j |> member "frame" |> to_int;
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
    action = Stand;
    is_enemy = j |> member "is_enemy" |> to_bool;
    size = lst_to_tuple size_tup;
    speed = j |> member "speed" |> to_int;
    location = j |> member "location"|> loc_of_json;
    health = (j |> member "health" |> to_float, j |> member "health" |> to_float);
    kill_count = j |> member "kill_count" |> to_int;
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
  } *)

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

(* helper function to get room via room id in state *)
let rec get_target_room all_rooms r_id =
  match all_rooms with
  | [] -> failwith "INVALID ROOM ID [get_target_room]"
  | room::t ->
    if room.room_id = r_id then room
    else get_target_room t r_id

(* helper function to get all objects in a room *)
let objects_in_room st =
  let room_id = st.current_room_id in
  let target_room = get_target_room st.all_rooms room_id in
  target_room.obj_lst


(* exec portal *)
let exec_portal portal target_sprite = 
  failwith "todo"

let exec_texture texture target_sprite = 
  failwith "todo"
(* helper function execute different actions based on what object sprite is trying to move to *)
(* let type_of_obj obj target_sprite = 
  match obj with 
  | Portal portal -> exec_portal portal target_sprite
  | Texture texture -> exec_texture
  | End _ -> false
  | Obstacle _ -> true *)

(* will have to tune this to some size.. ok for now
 * returns true if there is an obstacle or portal on square *)
(* let rec i_obj_on_square loc all_objs =
  match all_objs with
  | [] -> failwith "i_obj_on_square invalid"
  | obj::t ->
    if is_obst_or_portal obj then true
    else i_obj_on_square loc t *)

let can_move st loc =
  let all_objs = objects_in_room st in 
  failwith "todo"

let extract_loc_from_ob ob = 
  match ob with 
  | Portal portal -> portal.location
  | Texture texture -> texture
  | Obstacle obst -> obst
  | End loc -> loc

(* helper to return object at location loc *)
let rec get_obj_by_loc loc (all_objs: obj list) = 
  match all_objs with 
  | [] -> failwith "invalid setup [get_obj_by_loc]" 
  | h::t -> 
    let targ_loc = extract_loc_from_ob h in 
    if targ_loc = loc then h else 
    get_obj_by_loc loc t

(* list of all sprites but without the one being modified, useful when updating a sprite *)
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
let process_move dir st sprite_id curr_room =
  let target_sprite = get_sprite sprite_id st.all_sprites in
  let current_loc = (get_location sprite_id st).coordinate in
  let target_loc =
    match dir with
    | West -> ((fst current_loc) -. (target_sprite.speed *. 0.1), snd current_loc)
    | East -> ((fst current_loc) +. (target_sprite.speed *. 0.1), snd current_loc)
    | North -> (fst current_loc, (snd current_loc +. (target_sprite.speed *. 0.1)))
    | South -> (fst current_loc, (snd current_loc -. (target_sprite.speed *. 0.1))) in
  let new_loc = {target_sprite.location with coordinate = target_loc} in
  let target_obj = get_obj_by_loc new_loc curr_room.obj_lst in 
  match target_obj with 
  | Texture t -> 
    (let updated_sprite = {target_sprite with location = new_loc} in
    exec_move st updated_sprite)
  | _ -> failwith "todo "


let move_helper dir st sprite_id =
  process_move dir st sprite_id

let rec all_sprites_in_room (all_sprites: sprite list) (room_id: string) ret =
  match all_sprites with
  | [] -> ret
  | sprite::t ->
    if sprite.location.room = room_id then all_sprites_in_room t room_id (sprite::ret)
    else all_sprites_in_room t room_id ret

let sprite_room (sprite: sprite) =
  sprite.location.room

let update_size command sprite st =
  failwith "unimplimented"

let update_speed command sprite st =
  failwith "unimplimented"

let update_location command sprite st =
  failwith "unimplimented"

let update_health command sprite st =
  failwith "unimplimented"

let update_kill_count command sprite st =
  failwith "unimplimented"

let update_direction command sprite st =
  failwith "unimplimented"

let update_moving command sprite st =
  failwith "unimplimented"

let update_has_won command sprite st =
  failwith "unimplimented"

let sprite_take_action st sprite =
  let command =
    match sprite.name with
    | Enemy _ -> ai_command st sprite.id
    | Player -> player_command in
  {sprite with size = update_size command sprite st;
               speed = update_speed command sprite st;
               location = update_location command sprite st;
               health = update_health command sprite st;
               kill_count = update_kill_count command sprite st;
               direction = update_direction command sprite st;
               moving = update_moving command sprite st;

               has_won = update_has_won command sprite st}
                            
(* [getSprites sprites] parses a sprite list to
 * (player_sprite, other_sprites) *)
let getSprites st =
  let all_sprites = st.all_sprites in
  let isEnemy (sprite: sprite) =
    match sprite.name with
    | Enemy _ -> true
    | Player -> false in
  let rec spriteList sprites player other =
    match sprites with
    | []     -> (player, other)
    | h :: t ->
      if isEnemy h
      then spriteList t player (h :: other)
      else spriteList t (h :: player) other in
  spriteList all_sprites [] []
                 

let do' st =
  let sprites = getSprites st in
  let player = fst sprites in
  let enemy_sprites = snd sprites in
  let next_player_sprite = sprite_take_action st (List.hd player) in
  let current_room = sprite_room next_player_sprite in
  let next_enemy_sprites =
    List.fold_left
      (fun acc (sprite: sprite) ->
         if sprite_room sprite = current_room
         then (sprite_take_action st sprite) :: acc
         else sprite :: acc)
      [] enemy_sprites in
  let won = next_player_sprite.has_won in
  {st with all_sprites     = next_player_sprite :: next_enemy_sprites;
           has_won         = won;
           current_room_id = current_room}
            
(* do takes in state, recurively calls spriteAction on each sprite
 * returns state *)
(* sprite_take_action takes in command, state and calles helper functions
 * returns sprite *)
(* helper functions each update one field in sprite
 * returns field of sprite *)


let get_has_won st =
  st.has_won

let get_curr_room st =
  st.current_room_id
