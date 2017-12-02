open Ai
open Types

let player_command = {
  w = false;
  a = false;
  s = false;
  d = false;
  j = false;
  k = false;
  l = false;
}

let ai_command st id = makeAiCommand st id

let keydown event =
  let () = match event##keyCode with
    | 87 -> player_command.w <- true
    | 65 -> player_command.a <- true
    | 83 -> player_command.s <- true
    | 68 -> player_command.d <- true
    | 74 -> player_command.j <- true
    | 75 -> player_command.k <- true
    | 76 -> player_command.l <- true
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
