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
  size = (10., 10.);
  speed = 3.;
  location = {coordinate = (5. *. 26., 5. *. 26.); room = "start"};
  health = (20., 20.);
  kill_count = 0;
  direction = South;
  moves = [{id = "sword"; unlocked = true; frame = 5}];
  moving = false;
  params = {
    img = "sprites/spritesheet.png";
    frame_size = (15., 16.);
    offset = (0., 0.);
  };
  counter = 0;
  max_count = 0;
  frame_count = 0;
  max_frame = 1;
  image = "sprites/spritesheet.png";
  has_won = false;
}

let init_enemy = {
  id = 1;
  name = Enemy Blind;
  action = Stand;
  size = (5., 5.);
  speed = 0.0;
  location = {coordinate = (52., 104.); room = "start"};
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

let initial_state = {
  all_sprites = [initial_player];
  attack = (0.0,0.0), {coordinate = (0., 0.); room = "NONE"};
  has_won = false;

  all_rooms =
    [{room_id = "start"; width = 8.; height = 5.;

    obj_lst =
        [Portal { location = {coordinate = ( 26. *. 7., 7.*. 26.) ; room = "start"};
                  teleport_to = {coordinate = ( 26. *. 2., 5.*. 26.) ; room = "start"}};


         Obstacle {coordinate = ( 26. *. 8., 0.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 8., 1.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 8., 2.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 8., 3.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 8., 4.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 8., 5.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 8., 6.*. 26.) ; room = "start"};

         Obstacle {coordinate = ( 26. *. 5., 5.*. 26.) ; room = "start"};

         Obstacle {coordinate = ( 26. *. 4., 0.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 4., 1.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 4., 2.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 4., 3.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 4., 4.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 4., 5.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 4., 6.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 4., 7.*. 26.) ; room = "start"};

         Texture {coordinate = ( 26. *. 5., 0.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 5., 1.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 5., 2.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 5., 3.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 5., 4.*. 26.) ; room = "start"};
         (*         Texture {coordinate = ( 26. *. 5., 5.*. 26.) ; room = "start"}; *)

         Texture {coordinate = ( 26. *. 5., 6.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 5., 7.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 6., 0.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 6., 1.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 6., 2.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 6., 3.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 6., 4.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 6., 5.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 6., 6.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 6., 7.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 7., 0.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 7., 3.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 7., 1.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 7., 2.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 7., 4.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 7., 5.*. 26.) ; room = "start"};
         Texture {coordinate = ( 26. *. 7., 6.*. 26.) ; room = "start"}]};

     {room_id = "next"; width = 6.; height = 6.;
      obj_lst =
        [Portal { location = {coordinate = ( 26. *. 2., 5.*. 26.) ; room = "next"};
                  teleport_to = {coordinate = ( 26. *. 2., 7.*. 26.) ; room = "start"}};
         Portal { location = {coordinate = ( 26. *. 2., 5.*. 26.) ; room = "next"};
                  teleport_to = {coordinate = ( 26. *. 3., 7.*. 26.) ; room = "start"}};
         Portal { location = {coordinate = ( 26. *. 2., 5.*. 26.) ; room = "next"};
                  teleport_to = {coordinate = ( 26. *. 2., 8.*. 26.) ; room = "start"}};
         End {coordinate = ( 26. *. 5., 6.*. 26.) ; room = "next"};
         Obstacle {coordinate = ( 26. *. 3., 1.*. 26.) ; room = "next"}]}];
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

let state =  ref (adjust_all_coords initial_state)

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
    Gui.draw_state context !state;
    (* Gui.draw_image_on_context context (js !img_src ) (!x, !y); *)
    Html.window##requestAnimationFrame(
      Js.wrap_callback (fun (t:float) -> game_loop_helper ())
    ) |> ignore
  in game_loop_helper ()
