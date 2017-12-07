open Types

(* do` st takes in all commands (both player and AI) and updates
 * do takes in state, recurively calls spriteAction on each sprite
 * returns state *
 * the state and all sprites accordingly
 * requires: st is a state
 * returns: the state after each frame, with everything updated as per
 * the spec in the above functions *)
val do' : state -> state

