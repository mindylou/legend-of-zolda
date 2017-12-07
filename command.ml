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

(* The function to be called to make an ai command with state st and id id *)
let ai_command st id = makeAiCommand st id
