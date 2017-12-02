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

let ai_command = {
  w = false;
  a = false;
  s = false;
  d = false;
  j = false;
  k = false;
  l = false;
}

let keydown event =
  let () = match event##keyCode with
    | 87 -> player_command.w <- true
    | 65 -> player_command.a <- true
    | 83 -> player_command.s <- true
    | 68 -> player_command.d <- true
    | _ -> () (* other *)
  in Js._true

let keyup event =
  let () = match event##keyCode with
    | 87 -> player_command.w <- false
    | 65 -> player_command.a <- false
    | 83 ->player_command.s <- false
    | 68 -> player_command.d <- false
    | _ -> () (* other *)
  in Js._true
