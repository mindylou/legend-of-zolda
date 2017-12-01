open Types

type command

(* [getCommand ()] is the command that a player inputs on
 * a given frame *)
val player_command : command

(* [getAiCommand st] is the command that a ai inputs given
 * the current state st *)
