(* [state] is the type that will represent the current state of the game *)
type state

(* location is an (x, y) coordinate represented on our grid *)
type location 

(* the id of a sprite *)
type id 
(* move is move that has fields:
   id: string
   unlocked: bool
   frame: int *)
type move

(* moves is a list of all moves the sprite has *)
type moves 

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

(* if command is a move command: change the location of the sprite to the new location
   if the movement is not possible, do not alter the game state 
   if the command is an attack, execute it *)
val do' : Command.command -> state -> state