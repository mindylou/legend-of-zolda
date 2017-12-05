open Yojson.Basic.Util
open Types
open Command

let object_size = (27., 27.)
let sprite_movement = 3.0

(* [get_sprite] returns the sprite with id int 
 * requires: id is a valid sprite_id and lst is all the sprites 
 * returns: desired sprite based on id *)
let rec get_sprite (id: int) lst =
  match lst with
  | [] -> failwith "invalid sprite id [GET]"
  | h::t ->
    if h.id = id then h
    else get_sprite id t

(* returns player location in state *)
let get_player_location st =
  (get_sprite 0 st.all_sprites).location

(* helper function for all_sprite_locations
   requires: lst and ret are lists,
   returns: assoc list of name to location for each sprite *)
let rec location_helper (lst: sprite list) ret =
  match lst with
  | [] -> ret
  | sprite::t -> (sprite.name, sprite.location)::ret

(* returns location of all sprites in state *)
let all_sprite_locations st =
  let all_sprites = st.all_sprites in
  location_helper all_sprites []

(* [current_room_id st] is the current room that the player is in *)
let current_room_id st =
  st.current_room_id

(* [get_health id st] returns the health of sprite with id=id *)
let get_health id st =
  (get_sprite id st.all_sprites).health
(* [get_location id st] returns the location of the sprite with id =id *)
let get_location id st =
  (get_sprite id st.all_sprites).location

(* helper function to get direction of sprite
    requires: id is a sprite id, lst is a list of sprites *)
let get_sprite_direction id st =
  (get_sprite id st.all_sprites).direction

(* helper function to check of sprite is on a square *
   requires: all_sprites is the list of all_sprites, loc is a location *)
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

(* Checks to see if two coordinates w/ sizes are overlapping
* does not check to see if the coordinates are in the same room *)
let overlapping ((width1, height1), (x1,y1)) ((width2, height2), (x2,y2)) =
  let x1_min = x1 in
  let x1_max = x1 +. width1 in
  let y1_min = y1 in
  let y1_max = y1  +. height1 in

  let x2_min = x2 in
  let x2_max = x2 +. width2 in
  let y2_min = y2 in
  let y2_max = y2 +. height2 in

  let xs_overlap =
    if x1_min >= x2_min && x1_min <= x2_max ||
       x2_min >= x1_min && x2_min <= x1_max
    then true else false in
  let ys_overlap =
    if y1_min >= y2_min && y1_min <= y2_max ||
       y2_min >= y1_min && y2_min <= y1_max
    then true else false in
  xs_overlap && ys_overlap

(* [extract_loc_from_ob ob] returns the location that obj ob has *)
let extract_loc_from_ob ob =
  match ob with
  | Portal portal -> portal.location
  | Texture texture -> texture
  | Obstacle obst -> obst
  | End loc -> loc

(* helper to return object at location loc *)
let rec get_obj_by_loc sprite loc (all_objs: obj list) =
  match all_objs with
  | [] -> Texture loc
  | h::t ->
    let targ_loc = extract_loc_from_ob h in
    let overlap = (overlapping (sprite.size, loc.coordinate) (object_size, targ_loc.coordinate)) in
    if overlap then h else
    get_obj_by_loc sprite loc t

(* returns true if sprite is attemtping to move outside of playable area *)
let is_outside p_size loc height width = 
  (* fst loc < 0. || snd loc < 0. 
  || fst loc > width || snd loc > height  *)
  false

(* returns true if p is a player, false if p is an enemy *)
let is_player p = 
  match p.name with 
  | Player -> true
  | Enemy _-> false

(* [process_move command st sprite curr_room] returns an updated location,
 * based on the command (keys pressed), and the sprite. 
 * If the location is a portal, update current_room_id in state and teleport
 * the player to the new room.
 * Enemies cannot teleport *)
let process_move command st (sprite: sprite) curr_room =
  let target_sprite = sprite in
  let current_loc = sprite.location.coordinate in
  let x_off = 
    if command.d then sprite.speed 
    else if command.a then sprite.speed *. -1. 
    else 0. in 
  let y_off = 
    if command.s then sprite.speed 
    else if command.w then sprite.speed *. -1.
    else 0. in 
  let target_loc= ((fst current_loc +. x_off), snd current_loc +. y_off) in 
  
  let targ_room = get_target_room st.all_rooms st.current_room_id in
  if is_outside target_sprite.size target_loc  targ_room.height targ_room.width 
    then sprite.location
  else 
    let new_loc = {target_sprite.location with coordinate = target_loc} in
    if sprite.name = Enemy Boss then new_loc
    else 
    let target_obj = get_obj_by_loc target_sprite new_loc curr_room.obj_lst in
    match target_obj with
    | Texture t -> new_loc
    | Portal p when is_player sprite -> 
    st.current_room_id <- p.teleport_to.room;  p.teleport_to
    | Portal _  -> new_loc
    | Obstacle _ -> sprite.location
    | End _ -> new_loc

(* a helper function that calls process_move *)
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

let update_action command sprite st =
  if sprite.counter > sprite.max_count then Step
  else let () = sprite.counter <- sprite.counter + 1 in
  if command.w then Step
  else if command.a then Step
  else if command.s then Step
  else if command.d then Step
  else if command.j then Attack
  else if command.k then Attack
  else if command.l then Attack
  else sprite.action

(* Only the Boss enemy type changes its size depending on the move performed *)
let update_size command sprite st =
  match sprite.name with
  | Player -> sprite.size
  | Enemy e ->
    (match e with
     | Boss ->
       if command.k = true
       then (fst sprite.size) *. 1.2, (snd sprite.size) *. 1.2
       else sprite.size
     | _ -> sprite.size)

(* Only the Boss enemy type changes its speed depending on the move performed *)
let update_speed command sprite st =
  match sprite.name with
  | Player -> sprite.speed
  | Enemy e ->
    (match e with
     | Boss ->
       if command.j = true
       then sprite.speed *. 1.2
       else sprite.speed
     | _ -> sprite.speed)

let determine_direction command sprite =
  if command.w then North
  else if command.a then West
  else if command.s then South
  else if command.d then East
  else sprite.direction
         
let dir_key_pressed command =
  command.w || command.a || command.s || command.d
                                           
let rec gen_move_lst command ret = 
  if dir_key_pressed command then 
  if command.w then gen_move_lst ({command with w = false}) (North::ret)
  else if command.a then gen_move_lst ({command with a = false}) (West::ret)
  else  if command.s then gen_move_lst ({command with s = false}) (South::ret)
  else if command.d then gen_move_lst ({command with d = false}) (East::ret)
  else ret
  else ret

let update_location command (sprite: sprite) st =
  if dir_key_pressed command then
  (* let dir = determine_direction command sprite in *)
  process_move command st sprite (get_target_room st.all_rooms st.current_room_id)
  else sprite.location

(* [get_other_sprites st sprite_id] returns all of the sprites in
 * state whose id is not sprite_id *)
let get_other_sprites st id =
  let all_sprites = st.all_sprites in
  List.filter (fun sprite -> sprite.id <> id) all_sprites

(* updates the health of a sprite based on an overlap with either an
 * enemy sprite or an attack hitbox, depending on the type of sprite *)
let update_health command sprite st =
  let current_room = sprite_room sprite in
  let other_sprites = get_other_sprites st sprite.id in
  match sprite.name with
  | Player ->
    let got_hit = List.fold_left
        (fun acc other_sprite ->
           if sprite_room other_sprite <> current_room then false
           else
             (overlapping
                ((sprite.size), (sprite.location.coordinate))
                ((other_sprite.size), (other_sprite.location.coordinate))) || acc)
        false other_sprites in
      if got_hit then (fst sprite.health) -. 1.0, snd sprite.health else sprite.health
  | Enemy _ ->
    if (snd st.attack).room <> current_room then sprite.health
    else
      let got_hit = overlapping
          ((sprite.size), (sprite.location.coordinate))
          ((fst st.attack), (snd st.attack).coordinate) in
      if got_hit then (fst sprite.health) -. 10.0, snd sprite.health else sprite.health


let count_dead st =
  List.fold_left
    (fun acc sprite -> if fst sprite.health <= 0.0 then acc + 1 else acc)
    0 st.all_sprites

let update_kill_count command sprite st =
  sprite.kill_count + count_dead st

(* updates direction based on given command *)
let update_direction command sprite st =
  determine_direction command sprite

(* returns true if sprite is moving, else false *)
let update_moving command (sprite: sprite) st =
  let curr_loc = sprite.location in
  
  if dir_key_pressed command then
  let new_loc = process_move command st sprite (get_target_room st.all_rooms st.current_room_id) in
  curr_loc <> new_loc
  else false

(* returns true if player has won, else false *)
let update_has_won command sprite st =
  if sprite.name = Player then
  let targ_room = get_target_room st.all_rooms st.current_room_id in
  let obj_type = get_obj_by_loc sprite sprite.location targ_room.obj_lst in
  match obj_type with
  | End _ -> true
  | _ -> false
  else false

(* sprite takes action based on command and then each field
 * is updated individually with a helper function *)
let sprite_take_action st sprite =
  let command =
    match sprite.name with
    | Enemy _ -> ai_command st sprite.id
    | Player -> player_command in
  let new_health = update_health command sprite st in
  if fst new_health <= 0.0
  then match sprite.name with
    | Player -> [{sprite with health = -1., snd sprite.health}]
    | Enemy _ -> []
  else
    [{sprite with action = update_action command sprite st;
                  size = update_size command sprite st;
                  speed = update_speed command sprite st;
                  location = update_location command sprite st;
                  health = new_health;
                  kill_count = update_kill_count command sprite st;
                  direction = update_direction command sprite st;
                  moving = update_moving command sprite st;
                  has_won = update_has_won command sprite st}]

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

(* some constants *)
let blank_attack =
  (0.0,0.0), {coordinate = (0., 0.); room = "NONE"}
let sword_length = 20.
let sword_width = 16.

(* gets attack of player
 * requires: player is a sprite
 * returns: the attack with correct size/direction *)
let get_attack player =
  match player.action with
  | Attack ->
    let offsets_and_sizes = (match player.direction with
     | North -> (0., -. (sword_length /. 2.)), (sword_width, sword_length)
     | South -> (0., (sword_length /. 2.)), (sword_width, sword_length)
     | East  -> (sword_length /. 2., 0.), (sword_length, sword_width)
     | West  -> (-. (sword_length /. 2.), 0.), (sword_length, sword_width)) in
    let coordinates = player.location.coordinate in
    let offsets = fst offsets_and_sizes in
    let sizes = snd offsets_and_sizes in
    (sizes),
    {coordinate
     = ((fst coordinates) +. (fst offsets), (snd coordinates) +. (snd offsets));
     room = player.location.room}
  | _ -> blank_attack


(* do` st takes in all commands (both player and AI) and updates
 * do takes in state, recurively calls spriteAction on each sprite
 * returns state *
 * the state and all sprites accordingly
 * requires: st is a state
 * returns: the state after each frame, with everything updated as per
 * the spec in the above functions *)
let do' st =
  let sprites = getSprites st in
  let player = List.hd (fst sprites) in
  let enemy_sprites = snd sprites in
  let next_player_sprite = List.hd (sprite_take_action st player) in
  let current_room = sprite_room next_player_sprite in
  let next_enemy_sprites =
    List.fold_left
      (fun acc (sprite: sprite) ->
         if sprite_room sprite = current_room
         then (sprite_take_action st sprite) @ acc
         else sprite :: acc)
      [] enemy_sprites in
  let won = next_player_sprite.has_won in
  let attack = get_attack next_player_sprite in
  {st with all_sprites     = next_player_sprite :: next_enemy_sprites;
           has_won         = won;
           current_room_id = current_room;
           attack          = attack}

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
