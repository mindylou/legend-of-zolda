type id = string

type move =
  {
    id: string;
    unlocked: bool;
    frame: int
  }

type location =
  {
    coordinate: float * float;
    room: id;
  }

type direction = North | South | East | West

type sprite =
  {
    name: id;
    is_enemy: bool;
    size: int;
    speed: int;
    location: location;
    health: int;
    kill_count: int;
    direction: direction;

  }

type moves = move list

type portal =
  {
    location: location;
    teleport_to: location;
  }

type obj =
  | Portal of portal
  | Texture
  | Obstacle


type state =
  {
    player_location: location;
    all_sprites: sprite list;
    player_health: int;
    has_won: bool;
    player_kc: int;
    all_rooms: string list;
    all_objects: obj list;
  }

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
  failwith "todo"

let init_state = ()

let all_locations st = 
  failwith "todo"

let current_room_id st = 
  failwith "todo"

let do' cmd st = 
  failwith "todo"

let get_health id st = 
  (get_sprite id st.all_sprites).health

let get_location id st = 
  (get_sprite id st.all_sprites).location

(* helper function to get direction of sprite
   requires: id is a sprite id, lst is a list of sprites *)
  
let get_sprite_direction id st = 
  (get_sprite id st.all_sprites).health