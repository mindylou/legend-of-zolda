type id = int

type enemy_type = Random | Blind | Coop | Boss

type direction = North | South | East | West

type player_action =
  | Stand
  | Step
  | Attack

type sprite_type = Enemy of enemy_type | Player

type move =
  {
    id: string;
    unlocked: bool;
    frame: int;
  }

type location =
  {
    coordinate: float * float;
    room: string;
  }


type total_health = float

type sprite =
  {
    id: int;
    name: sprite_type;
    action: player_action;
    is_enemy: bool;
    size: (float*float);
    speed: int;
    location: location;
    health: float * total_health;
    kill_count: int;
    direction: direction;
    moves: move list;
    moving: bool;
    mutable counter: int ref;
    max_count: int;
    mutable frame_count: int ref;
    max_frame: int;
    image: string; 
  }


type portal =
  {
    location: location;
    teleport_to: location;
  }

type obj =
  | Portal of portal
  | Texture of location
  | Obstacle of location
  | End of location


type room =
  {
    room_id: string;
    width: float;
    height: float;
    obj_lst: obj list;
  }

type state =
  {
    all_sprites: sprite list;
    has_won: bool;
    all_rooms: room list;
    current_room_id: string;
  }

type command = {
  mutable w : bool;
  mutable a : bool;
  mutable s : bool;
  mutable d : bool;
  mutable j : bool;
  mutable k : bool;
  mutable l : bool;
}
