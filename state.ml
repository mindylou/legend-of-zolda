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

let location st = failwith "Unimplemented"

let init_state = failwith "Unimplemented"

let current_health id st = failwith "Unimplemented"

let enemy_locations st = failwith "Unimplemented"

let get_location id st = failwith "Unimplemented"

let current_room_id st = failwith "Unimplemented"

let do' cmd st = failwith "Unimplemented"
