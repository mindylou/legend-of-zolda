open Types
open Command
open Sprites

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

(* initial state *)
let initial_state = {
  all_sprites = [player; enemy2; enemy3; enemy4; enemy5; enemy6;
                 enemy7; enemy8; enemy9; enemy10; enemy12; enemy13; enemy14;
                 enemy15; enemy16; enemy17; enemy_stationary];

  attack = (0.0,0.0), {coordinate = (0., 0.); room = "start"};
  has_won = false;
  all_rooms =
    [ Rooms.start; Rooms.room1; Rooms.room2];
  current_room_id = "start"
}

(* mutable ref to store the current game state *)
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

(* the main game loop *)
let game_loop context has_won =
  let rec game_loop_helper () =
    state := State.do' !state;
    Gui.draw_state context !state;
    Html.window##requestAnimationFrame(
      Js.wrap_callback (fun (t:float) -> game_loop_helper ())
    ) |> ignore
  in game_loop_helper ()
