open Types

(* returns the location as an (x, y) tuple *)
val get_player_location : state -> location

(* the initialized game *)
val init_state : unit

(* current health sprite of sprite, takes in a state and sprite id and returns health as an int *)
val get_health: id -> state -> int

(* returns an assoc list of all sprites_ids to their locations,
   order is irrelevant *)
val all_sprite_locations: state -> id * location list

(* takes in id of sprite and state and returns its location *)
val get_location: id -> state -> location

(* [current_room_id s] is the id of the room in which the adventurer
 * currently is. *)
 val current_room_id : state -> string

(* if command is a move command: change the location of the sprite to the new location
   if the movement is not possible, do not alter the game state
   if the command is an attack, execute it *)
val do' : Command.command -> state -> state

val get_sprite_direction: id -> state -> direction

val type_of_square: location -> state -> square_type
