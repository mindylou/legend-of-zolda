(* the id (name) of a sprite *)
type id = string 
open Command
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
  coordinate: int * int;
  room: id;
}


(* cardinal direction a sprite can face *)
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
  }

(* returns the location as an (x, y) tuple *)
val location : state -> location 

(* the initialized game *)
val init_state : unit

(* current sprite of sprite, takes in a state and sprite id and returns health as an int *)
val current_health: id -> state -> int

(* returns an assoc list of all alive enemies to their locations,
   order is irrelevant *)
val enemy_locations: state -> string * location list

(* takes in id of sprite and state and returns its location *)
val get_location: id -> state -> location

(* [current_room_id s] is the id of the room in which the adventurer
 * currently is. *)
 val current_room_id : state -> string

(* if command is a move command: change the location of the sprite to the new location
   if the movement is not possible, do not alter the game state 
   if the command is an attack, execute it *)
val do' : Command.command -> state -> state
