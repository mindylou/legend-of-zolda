open Types

(* [getCommand ()] is the command that a player inputs on
 * a given frame *)
val getPlayerCommand : unit -> command

(* [getAiCommand st] is the command that a ai inputs given 
 * the current state st *)
val getAiCommand : Types.state -> Types.id -> command

