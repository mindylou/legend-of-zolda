open Types

(* drawing canvas width *)
val canvas_width: float

(* drawing canvas height *)
val canvas_height: float

val win_screen : Dom_html.canvasRenderingContext2D Js.t -> unit

(* [draw_image_on_context context img_src x y] draws the given [img_src]
   string at the x,y [coord] on the canvas' [context]. *)
val draw_image_on_context: Dom_html.canvasRenderingContext2D Js.t ->
  Js.js_string Js.t -> (float * float) -> unit

val draw_objects: Dom_html.canvasRenderingContext2D Js.t -> Types.obj list -> unit

val clear: Dom_html.canvasRenderingContext2D Js.t -> unit

val update_animations: sprite -> unit

val update_all_animations: sprite list -> unit

(* [draw_state canvas state] draws the current state onto the [canvas]. *)
val draw_state: Dom_html.canvasRenderingContext2D Js.t -> Types.state -> unit
