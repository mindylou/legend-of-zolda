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

type frame_params =
  {
    img: string;
    frame_size: float * float;
    offset: float * float;
  }

type total_health = float

type sprite =
  {
    id: int;
    name: sprite_type;
    action: player_action;
    mutable size: (float*float);
    speed: float;
    location: location;
    health: float * total_health;
    kill_count: int;
    direction: direction;
    moves: move list;
    moving: bool;
    mutable params: frame_params;
    mutable counter: int;
    mutable max_count: int;
    mutable frame_count: int;
    mutable max_frame: int;
    image: string;
    has_won: bool
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
    mutable current_room_id: string;
    attack: (float * float) * location
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
