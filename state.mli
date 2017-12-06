open Types

(* if command is a move command: change the location of the sprite to the new location
   if the movement is not possible, do not alter the game state
   if the command is an attack, execute it *)
val do' : state -> state

