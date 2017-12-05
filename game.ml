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
  size = (15., 15.);
  speed = 8.;
  location = {coordinate = (160., 0.); room = "start"};
  health = (100., 100.);
  kill_count = 0;
  direction = South;
  moves = [{id = "sword"; unlocked = true; frame = 5}];
  moving = false;
  params = {
    img = "sprites/spritesheet.png";
    frame_size = (20., 20.);
    offset = (0., 0.);
  };
  counter = 0;
  max_count = 10;
  frame_count = 1;
  max_frame = 1;
  image = "sprites/spritesheet.png";
  has_won = false;
}

let init_enemy1 = {
  id = 1;
  name = Enemy Blind;
  action = Stand;
  size = (15., 15.);
  speed = 1.;
  location = {coordinate = (160., 140.); room = "start"};
  health = (1., 1.);
  kill_count = 0;
  direction = North;
  moves = [{id = "sword"; unlocked = false; frame = 5}];
  moving = false;
  params = {
    img = "sprites/enemysprites.png";
    frame_size= (12.,16.);
    offset = (133., 91.);
  };
  counter =  0;
  max_count = 0;
  frame_count =  0;
  max_frame = 1;
  image = "sprites/enemysprites.png";
  has_won = false;
}

let init_enemy2 =
  {init_enemy1 with location = {coordinate = (26. *. 6., 8. *. 26.);
                                room = "room1";};
                    id = 2}

let init_enemy3 =
  {init_enemy1 with location = {coordinate = (26. *. 6., 4. *. 26.);
                                room = "room1";};
                    id = 3}

let init_enemy4 =
  {init_enemy1 with location = {coordinate = (26. *. 10., 6. *. 26.);
                                room = "room1";};
                    id = 4}

let init_enemy5 =
  {init_enemy1 with location = {coordinate = (26. *. 14., 4. *. 26.);
                                room = "room1";};
                    id = 5;
                    name = Enemy Coop}

let init_enemy6 =
  {init_enemy1 with location = {init_enemy1.location with coordinate = (160.,250.)};
                    id = 6;
                    name = Enemy Coop}

let init_enemy7 =
  {init_enemy1 with location = {init_enemy1.location with coordinate = (300.,300.)};
                    id = 7;
                    name = Enemy Coop}

let init_enemy8 =
  {init_enemy1 with location = {init_enemy1.location with coordinate = (250.,300.)};
                    id = 8;
                    name = Enemy Coop}


let initial_state = {
  all_sprites = [initial_player; ];
                 (* init_enemy1; init_enemy2; init_enemy3; init_enemy4;
                 init_enemy5;]; *)
  attack = (0.0,0.0), {coordinate = (0., 0.); room = "NONE"};
  (*  attack = (10.0,10.0), {coordinate = (26. *. 6., 26. *. 6. ); room = "start"}; *)
  has_won = false;

  all_rooms =
    [ Rooms.start; Rooms.room1;];
  current_room_id = "start"}


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

let state = ref (initial_state)

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
    | 87 -> player_command.w <- false; state := State.do' !state
    | 65 -> player_command.a <- false; state := State.do' !state
    | 83 -> player_command.s <- false; state := State.do' !state
    | 68 -> player_command.d <- false; state := State.do' !state
    | 74 -> player_command.j <- false; state := State.do' !state
    | 75 -> player_command.k <- false; state := State.do' !state
    | 76 -> player_command.l <- false; state := State.do' !state
    | _ -> () (* other *)
  in Js._true

let game_loop context has_won =
  let rec game_loop_helper () =
    state := State.do' !state;
    Gui.draw_state context !state;
    (* Gui.draw_image_on_context context (js !img_src ) (!x, !y); *)
    Html.window##requestAnimationFrame(
      Js.wrap_callback (fun (t:float) -> game_loop_helper ())
    ) |> ignore
  in game_loop_helper ()
