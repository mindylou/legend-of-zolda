open Types

(* drawing canvas width *)
val canvas_width: float

(* drawing canvas height *)
val canvas_height: float

(* [draw_state canvas state] draws the current state onto the [canvas]. *)
val draw_state: Dom_html.canvasRenderingContext2D Js.t -> state -> unit
