open Types
open Command
open Sprites

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document


let initial_state = {
  all_sprites = [player; enemy1; enemy2; enemy3; enemy4; enemy5; enemy6;
                 enemy7; enemy8; enemy9; enemy10; enemy12; enemy13; enemy14;
                 enemy15; enemy16;];

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
