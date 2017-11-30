
(* drawing canvas width *)
val canvas_width: float

(* drawing canvas height *)
val canvas_height: float

(* [draw_state context state] draws the current state onto the context. *)
val draw_state: Dom_html.canvasElement Js.t -> Types.state -> unit
