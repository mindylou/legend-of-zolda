
(* drawing canvas width *)
val canvas_width: float

(* drawing canvas height *)
val canvas_height: float

(* [draw_image_on_context context img_src x y] draws the given [img_src]
   string at the x,y [coord] on the canvas' [context]. *)
val draw_image_on_context: Dom_html.canvasRenderingContext2D Js.t ->
  Js.js_string Js.t -> (float * float) -> unit

val clear: Dom_html.canvasRenderingContext2D Js.t -> unit

(* [draw_state canvas state] draws the current state onto the [canvas]. *)
val draw_state: Dom_html.canvasRenderingContext2D Js.t -> Types.state -> unit
