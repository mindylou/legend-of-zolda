open Types

(* [getCommand ()] is the command that a player inputs on
 * a given frame *)
val player_command : Types.command

(* The function to be called to make an ai command with state st and id id *)
val ai_command : state -> id -> command
