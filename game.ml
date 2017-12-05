open Types
open Command

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

let initial_player = {
  id = 0;
  name = Player;
  action = Stand;
  size = (1., 1.);
  speed = 1.;
  location = {coordinate = (52., 0.); room = "start"};
  health = (20., 20.);
  kill_count = 0;
  direction = South;
  moves = [{id = "sword"; unlocked = true; frame = 5}];
  moving = false;
  counter = ref 0;
  max_count = 0;
  frame_count = ref 0;
  max_frame = 1;
  image = "sprites/spritesheet.png";
  has_won = false;
}

(* let init_enemy = {
  id = 1;
  name = Enemy Blind;
  action = Stand;
  size = (1., 1.);
  speed = 1.;
  location = {coordinate = (52., 104.); room = "start"};
  health = (1., 1.);
  kill_count = 0;
  direction = North;
  moves = [{id = "sword"; unlocked = false; frame = 5}];
  moving = false;
  counter = ref 0;
  max_count = 0;
  frame_count = ref 0;
  max_frame = 1;
  image = "sprites/enemysprites.png";
  has_won = false;
} *)

let initial_state = {
  all_sprites = [initial_player; ];
  attack = (0.0,0.0), {coordinate = (0., 0.); room = "NONE"};
  has_won = false;
  all_rooms =
    [{room_id = "start"; width = 8.; height = 5.;
      obj_lst =
        [Portal { location = {coordinate = (2., 7.); room = "start"};
                  teleport_to = {coordinate = (2., 5.); room = "start"}};
         Obstacle {coordinate = (4., 0.); room = "start"};
         Obstacle {coordinate = (4., 1.); room = "start"};
         Obstacle {coordinate = (4., 2.); room = "start"};
         Obstacle {coordinate = (4., 3.); room = "start"};
         Obstacle {coordinate = (4., 4.); room = "start"};
         Obstacle {coordinate = (4., 5.); room = "start"};
         Obstacle {coordinate = (4., 6.); room = "start"};
         Obstacle {coordinate = (4., 7.); room = "start"};
         Obstacle {coordinate = (0., 0.); room = "start"};
         Obstacle {coordinate = (0., 1.); room = "start"};
         Obstacle {coordinate = (0., 2.); room = "start"};
         Obstacle {coordinate = (0., 3.); room = "start"};
         Obstacle {coordinate = (0., 4.); room = "start"};
         Obstacle {coordinate = (0., 5.); room = "start"};
         Obstacle {coordinate = (0., 6.); room = "start"};
         Obstacle {coordinate = (0., 7.); room = "start"};
         Texture {coordinate = (1., 0.); room = "start"};
         Texture {coordinate = (1., 1.); room = "start"};
         Texture {coordinate = (1., 2.); room = "start"};
         Texture {coordinate = (1., 3.); room = "start"};
         Texture {coordinate = (1., 4.); room = "start"};
         Texture {coordinate = (1., 5.); room = "start"};
         Texture {coordinate = (1., 6.); room = "start"};
         Texture {coordinate = (1., 7.); room = "start"};
         Texture {coordinate = (3., 0.); room = "start"};
         Texture {coordinate = (3., 1.); room = "start"};
         Texture {coordinate = (3., 2.); room = "start"};
         Texture {coordinate = (3., 3.); room = "start"};
         Texture {coordinate = (3., 4.); room = "start"};
         Texture {coordinate = (3., 5.); room = "start"};
         Texture {coordinate = (3., 6.); room = "start"};
         Texture {coordinate = (3., 7.); room = "start"};
         Texture {coordinate = (2., 0.); room = "start"};
         Texture {coordinate = (2., 3.); room = "start"};
         Texture {coordinate = (2., 1.); room = "start"};
         Texture {coordinate = (2., 2.); room = "start"};
         Texture {coordinate = (2., 4.); room = "start"};
         Texture {coordinate = (2., 5.); room = "start"};
         Texture {coordinate = (2., 6.); room = "start"}]};
     {room_id = "next"; width = 6.; height = 6.;
      obj_lst =
        [Portal { location = {coordinate = (2., 5.); room = "next"};
                  teleport_to = {coordinate = (2., 7.); room = "start"}};
         End {coordinate = (4., 2.); room = "next"};
         Obstacle {coordinate = (3., 1.); room = "next"}]}];
      current_room_id = "next"}

let adjust_coordinates rm =
  let object_new_loc o =
    let (x, y) = o.coordinate in
    {o with coordinate = (x *. 26., y *. 26.)} in
  let new_obj_lst = List.map (fun obj ->
      match obj with
      | Texture l -> Texture (object_new_loc l)
      | Obstacle l -> Obstacle (object_new_loc l)
      | End l -> End (object_new_loc l)
      | Portal p -> Portal {p with location = (object_new_loc p.location)}
    ) rm.obj_lst in
  {rm with obj_lst = new_obj_lst}

let adjust_all_coords st =
  let updated_rooms = List.map adjust_coordinates st.all_rooms in
  {st with all_rooms = updated_rooms}

(* let x = ref 0.
let y = ref 0.
let img_src = ref "sprites/front.png" *)

let state = ref (adjust_all_coords initial_state)

(* let do' st = *)
  (* get new state from state's do'
     then look through sprites and update the frame types for the sprites
     then draw the sprites
  *)
  (* let new_st = State.do' st in *)

  (* if player_command.w = true then (y := !y -. 3.; img_src := "sprites/back.png")
  else if player_command.a = true then (x := !x -. 3.; img_src := "sprites/left.png")
  else if player_command.s = true then (y := !y +. 3.; img_src := "sprites/front.png";)
  else if player_command.d = true then (x := !x +. 3.; img_src := "sprites/right.png")
  else () *)

let keydown event =
  let () = match event##keyCode with
    | 87 -> player_command.w <- true; state := State.do' !state
    | 65 -> player_command.a <- true; state := State.do' !state
    | 83 -> player_command.s <- true; state := State.do' !state
    | 68 -> player_command.d <- true; state := State.do' !state
    | 74 -> player_command.j <- true; state := State.do' !state
    | 75 -> player_command.k <- true; state := State.do' !state
    | 76 -> player_command.l <- true; state := State.do' !state
    | _ -> () (* other *)
  in Js._true

let keyup event =
  let () = match event##keyCode with
    | 87 -> player_command.w <- false
    | 65 -> player_command.a <- false
    | 83 -> player_command.s <- false
    | 68 -> player_command.d <- false
    | 74 -> player_command.j <- false
    | 75 -> player_command.k <- false
    | 76 -> player_command.l <- false
    | _ -> () (* other *)
  in Js._true

let game_loop context has_won =
  let rec game_loop_helper () =
    state := State.do' !state;
    Gui.clear context;
    Gui.draw_state context !state;
    (* Gui.draw_image_on_context context (js !img_src ) (!x, !y); *)
    Html.window##requestAnimationFrame(
      Js.wrap_callback (fun (t:float) -> game_loop_helper ())
    ) |> ignore
  in game_loop_helper ()
