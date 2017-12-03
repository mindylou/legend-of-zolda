open Types

(* [json_to_init_state j] reads in the json from the given file name and
   initializes the state. *)
val json_to_init_state: string -> state

(* [game_loop context st has_won] controls the game loop and draws the updates
   to the canvas *)
val game_loop: Dom_html.canvasRenderingContext2D Js.t -> bool -> unit

val keydown : Dom_html.keyboardEvent Js.t -> bool Js.t

val keyup : Dom_html.keyboardEvent Js.t -> bool Js.t
