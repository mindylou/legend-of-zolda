(* the id (name) of a sprite *)
type id = int

type enemy_type = Random | Blind | Coop | Boss

(* cardinal direction a sprite can face *)
type direction = North | South | East | West

type player_action =
  | Stand
  | Step
  | Attack

type sprite_type = Enemy of enemy_type | Player

(* move is move that has fields:
   id: string
   unlocked: bool
   frame: int *)
type move =
  {
    id: string;
    unlocked: bool;
    frame: int;
  }

(* location is an (x, y) coordinate represented on our grid *)
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
    size: (float * float);
    speed: float;
    location: location;
    health: float * total_health;
    kill_count: int;
    direction: direction;
    moves: move list;
    moving: bool;
    params: frame_params;
    mutable counter: int; (* counts how long you're on a sprite for *)
    max_count: int; (* how long each sprite will last *)
    mutable frame_count: int; (* # sprite you're on *)
    max_frame: int; (* number of sprites you need to cycle through *)
    image: string;
    has_won: bool
  }
(* moves is a list of all moves the sprite has *)

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

(* [state] is the type that will represent the current state of the game *)
type state =
  {
    all_sprites: sprite list;
    has_won: bool;
    all_rooms: room list;
    current_room_id: string;
    attack: (float * float) * location
  }

(* [command] represents a command input by a player. *)
type command = {
  mutable w : bool;
  mutable a : bool;
  mutable s : bool;
  mutable d : bool;
  mutable j : bool;
  mutable k : bool;
  mutable l : bool;
}
