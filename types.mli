(* the id (name) of a sprite *)
type id = string

(* move is move that has fields:
   id: string
   unlocked: bool
   frame: int *)
type move =
  {
    id: string;
    unlocked: bool;
    frame: int
  }

(* location is an (x, y) coordinate represented on our grid *)
type location =
{
  coordinate: float * float;
  room: id;
}


(* cardinal direction a sprite can face *)
type direction = North | South | East | West

type sprite =
  {
    id : int;
    name: id;
    is_enemy: bool;
    size: int;
    speed: int;
    location: location;
    health: int;
    kill_count: int;
    direction: direction;

  }
(* moves is a list of all moves the sprite has *)
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

type square_type =
  Obj of obj | Sprite of sprite

type square =
  {
    square_type: square_type;
    location: location;
  }
(* [state] is the type that will represent the current state of the game *)
type state =
  {
    player_location: location;
    all_sprites: sprite list;
    player_health: int;
    has_won: bool;
    player_kc: int;
    all_rooms: string list;
    all_objects: obj list;
    current_room_id: string;
  }

(* [command] represents a command input by a player. *)
type command = {w: bool;
                a: bool;
                s: bool;
                d: bool;
                j: bool;
                k: bool;
                l: bool}
