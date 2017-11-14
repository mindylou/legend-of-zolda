(* [command] represents a command input by a player. *)
type command = {w: bool;
                a: bool;
                s: bool;
                d: bool;
                j: bool;
                k: bool;
                l: bool}

(* [getCommand ()] is the command that a player inputs on
 * a given frame *)
val getPlayerCommand : unit -> command

(* [getAiCommand ()] is the command that a ai inputs on
 * a given frame *)
val getAiCommand : unit -> command

