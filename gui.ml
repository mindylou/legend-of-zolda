open Types
(* NOTE: if we want to cycle through animations (walking, for example)
   with sprite sheets, we need to cycle through frames -
   see this: https://gamedevelopment.tutsplus.com/tutorials/an-introduction-to-spritesheet-animation--gamedev-13099 *)

(* [object pixel width and height ]*)
let object_wh = 30.

let canvas_width = 1000.
let canvas_height = 600.

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

type frame =
  {
    img: string;
    frame_size: float * float;
    offset: float * float;
    mutable f_length: int ref;
  }

(* [player_img_assoc] returns the image path associated with the player. *)
let player_img_assoc (dir: direction) =
  match dir with
  | North -> js "sprites/back.png"
  | South -> js "sprites/front.png"
  | East -> js "sprites/right.png"
  | West -> js "sprites/left.png"

(* [enemy_img_assoc] returns the image associated with the enemy. *)
let enemy_img_assoc = function
  | Blind -> js "sprites/blob.png"
              (* frame_size= (12.,16.);
              offset = (133., 91.); f_length = ref 0;} *)
  | Coop -> js "sprites/enemysprites.png"
          (* ; frame_size= (16.,16.);
             offset = (58., 73.); f_length = ref 0;} *)
  | Boss ->  js "sprites/enemysprites.png"
           (* ; frame_size= (14.,16.);
              offset = (132., 0.); f_length = ref 0;} *)
  | Random ->  js "sprites/enemysprites.png"
             (* ; frame_size= (16.,16.);
                offset = (56., 19.); f_length = ref 0;} *)

(* [obj_img_assoc] returns the image path associated with the object. *)
let obj_img_assoc = function
  | Portal _ -> js "sprites/door.png"
  | Texture _ -> js "sprites/texture.png"
  | Obstacle _ -> js "sprites/obstacle.png"
  | End _ -> js "sprites/end.png"

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

(* [sprites_in_room sprites_list room_id] returns a list of all sprites in
   that room given the room_id. *)
let sprites_in_room (sprites_list: sprite list) room_id =
  List.filter (fun (s: sprite) -> s.location.room = room_id) sprites_list

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
  let img_src = begin
    match (sprite.name: sprite_type) with
    | Enemy e -> enemy_img_assoc e
    | Player -> player_img_assoc sprite.direction
    end in
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

let draw_sprites (context: Html.canvasRenderingContext2D Js.t) sprite_list =
  List.map (fun spr -> draw_sprite context spr) sprite_list |> ignore

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

let find_player sprite =
  let img = "sprites/spritesheet.png" in
  match sprite.direction with
  | North -> (begin
      match sprite.action with
      | Stand -> {img; frame_size = (12., 16.); offset = (62., 0.); f_length = ref 0;}
      | Step -> {img; frame_size = (12., 16.); offset = (62., 30.); f_length = ref 3;}
      | Attack -> {img; frame_size = (16., 28.); offset = (60., 84.); f_length = ref 8;}
    end)
  | South -> (begin
      match sprite.action with
      | Stand -> { img; frame_size = (15., 16.); offset = (0., 0.); f_length = ref 0;}
      | Step -> {img; frame_size = (15., 16.); offset = (1., 30.); f_length = ref 3;}
      | Attack -> {img; frame_size = (16., 27.); offset = (0., 84.); f_length = ref 8;}
    end)
  | East -> (begin
      match sprite.action with
      | Stand -> {img; frame_size = (15., 16.); offset = (91., 0.); f_length = ref 0;}
      | Step -> {img; frame_size = (15., 16.); offset = (90., 30.); f_length = ref 3;}
      | Attack -> {img; frame_size = (27., 15.); offset = (84., 90.); f_length = ref 8;}
    end)
  | West -> (begin
      match sprite.action with
      | Stand -> {img; frame_size = (15., 16.); offset = (30., 0.); f_length = ref 0;}
      | Step -> {img; frame_size = (14., 15.); offset = (31., 30.); f_length = ref 3;}
      | Attack -> {img; frame_size = (27., 15.); offset = (24., 90.); f_length = ref 8;}
    end)

(* [update_animations sprite] updates the animations (for sprite sheet stuff) *)
let update_animations sprite =
  let count = !(sprite.counter) in
  if count >= sprite.max_count then
    sprite.counter := 0
  else
    sprite.frame_count := (!(sprite.frame_count) + 1) mod sprite.max_frame;
    sprite.counter := count + 1

let draw_state (context: Html.canvasRenderingContext2D Js.t) state =
  clear context;
  if state.has_won then (win_screen context)
  else
    let player_lst = List.filter (fun s -> s.name = Player) state.all_sprites in
    let contains_player = player_lst <> [] in
    if contains_player then
      let player = List.hd player_lst in
      if (fst player.health) > 0. then
        let current_rm = find_with_failwith
            (fun rm -> print_endline (rm.room_id);
              print_endline (state.current_room_id);
              rm.room_id = state.current_room_id)
            state.all_rooms
            "Cannot find current room" in
        draw_room context current_rm;
        draw_sprites context (sprites_in_room state.all_sprites
                                state.current_room_id);
      else lose_screen context
    else lose_screen context
