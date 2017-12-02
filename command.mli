open Types

(* [getCommand ()] is the command that a player inputs on
 * a given frame *)
val player_command : Types.command

val ai_command : state -> id -> command

val keydown : Dom_html.keyboardEvent Js.t -> bool Js.t

val keyup : Dom_html.keyboardEvent Js.t -> bool Js.t
