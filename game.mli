open Types

(* [game_loop context st has_won] controls the game loop and draws the updates
   to the canvas *)
val game_loop: Dom_html.canvasRenderingContext2D Js.t -> bool -> unit

(* [keydown event] registers when a key has been pressed. *)
val keydown : Dom_html.keyboardEvent Js.t -> bool Js.t

(* [keyup event] registers when a key has been lifted. *)
val keyup : Dom_html.keyboardEvent Js.t -> bool Js.t
