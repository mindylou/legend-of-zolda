open Types

(* NOTE: if we want to cycle through animations (walking, for example)
   with sprite sheets, we need to cycle through frames -
   see this: https://gamedevelopment.tutsplus.com/tutorials/an-introduction-to-spritesheet-animation--gamedev-13099 *)

(* [object pixel width and height ]*)
let object_wh = 30.

let canvas_width = 700.
let canvas_height = 500.

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

(* [player_img_assoc] returns the image path associated with the player. *)
let player_img_assoc = function
  | North -> js "sprites/back.png"
  | South -> js "sprites/front.png"
  | East -> js "sprites/right.png"
  | West -> js "sprites/left.png"

(* [enemy_color_assoc] returns the color associated with the enemy. *)
let enemy_color_assoc = function
  | Blind -> "black"
  | Coop -> "blue"
  | Boss -> "red"
  | Random -> "yellow"

(* [obj_img_assoc] returns the image path associated with the object. *)
let obj_img_assoc = function
  | Portal _ -> js "sprites/portal.png"
  | Texture _ -> js "sprites/texture.png"
  | Obstacle _ -> js "sprites/obstacle.png"
  | End _ -> js "sprites/portal.png" (* TODO: change this *)

(* [obj_coord_assoc] returns the coordinate associated with the object. *)
let obj_coord_assoc = function
  | Portal p -> p.location.coordinate
  | Texture l | Obstacle l | End l -> l.coordinate

(* [is_walkable obj] determines if an object on the map is walkable or not *)
let is_walkable = function
  | Portal _ | Texture _  | End _ -> true
  | Obstacle _ -> false

(* [find_with_failwith] performs [List.find f lst], but if it raises
   Not_found, the function with fail with a custom fail message. *)
let find_with_failwith f lst fail_msg =
  try List.find f lst with Not_found -> failwith fail_msg

(************************ DRAWING ************************)

(* [draw_image_on_context context img_src x y] draws the given [img_src]
   string at the x,y [coord] on the canvas' [context]. *)
let draw_image_on_context context img_src coord =
  let img = Html.createImg document in
  img##src <- img_src;
  context##drawImage ((img), (fst coord), (snd coord))

(* [fill_rect context (x,y) (w,h)] fills the given [x,y] with width [w]
   and height [h] with [color]. *)
let fill_rect context color (x,y) (w, h) =
  context##fillStyle <- (js color);
  context##fillRect (x, y, w, h)

(* [draw_sprite context sprite] draws the sprite on the given context. *)
let draw_sprite (context: Html.canvasRenderingContext2D Js.t) (sprite: sprite) =
  match sprite.name with
  | Enemy e -> fill_rect context (enemy_color_assoc e)
                 sprite.location.coordinate
                 sprite.size
  | Player -> let img_src = player_img_assoc sprite.direction in
    draw_image_on_context context img_src sprite.location.coordinate

(* [draw_kill_count context player] draws the kill count of the player. *)
let draw_kill_count (context: Html.canvasRenderingContext2D Js.t) player =
  let kill_count_str = js ("Kill count: " ^ string_of_int player.kill_count) in
  context##fillStyle <- js "black";
  context##fillText
    (kill_count_str, 10., 10.)

(* [draw_objects context objects_in_room] draws all of the basic map objects
   in the current room given by the [room_id]. *)
let draw_objects (context: Html.canvasRenderingContext2D Js.t)
    (objects_in_room: obj list) =
  List.map (fun obj ->
      draw_image_on_context context
        (obj_img_assoc obj)
        (obj_coord_assoc obj))
    objects_in_room
  |> ignore

(* [draw_room context room objects_list] draws the background
   and layout of the room. *)
let draw_room (context: Html.canvasRenderingContext2D Js.t) room =
  context##fillStyle <- js "black";
  context##fillRect (0., 0., canvas_width, canvas_height);
  draw_objects context room.obj_lst

(* [win_screen context] draws the win screen. *)
let win_screen (context: Html.canvasRenderingContext2D Js.t) =
  context##fillStyle <- js "black";
  context##fillRect (0., 0., canvas_width, canvas_height);
  context##fillStyle <- js "white";
  context##font <- js "100px sans-serif";
  context##textAlign <- js "center";
  context##fillText ((js "YOU WIN!"), canvas_width/.2., canvas_height/.2.)

(* [lose_screen context] draws the lose screen. *)
let lose_screen (context: Html.canvasRenderingContext2D Js.t) =
  context##fillStyle <- js "black";
  context##fillRect (0., 0., canvas_width, canvas_height);
  context##fillStyle <- js "white";
  context##font <- js "100px sans-serif";
  context##textAlign <- js "center";
  context##fillText ((js "GAME OVER."), canvas_width/.2., canvas_height/.2.)

(************************ ANIMATION ************************)

(* [clear canvas] clears the canvas of all drawing. *)
let clear (context: Html.canvasRenderingContext2D Js.t) =
  context##clearRect (0., 0., canvas_width, canvas_height)

(* [update_animations sprite] updates the animations (for sprite sheet stuff) *)
let update_animations sprite =
  failwith "Unimplemented"

let draw_state (context:  Html.canvasRenderingContext2D Js.t) state =
  clear context;
  if state.has_won then (win_screen context)
  else
    let player = find_with_failwith
        (fun spr -> spr.name = Player)
        state.all_sprites
        "Cannot find Player sprite" in
    if player.health <= 0 then (lose_screen context)
    else
    let current_rm = find_with_failwith
        (fun rm -> rm.room_id = state.current_room_id)
        state.all_rooms
        "Cannot find current room" in
    draw_room context current_rm;
    draw_kill_count context player
