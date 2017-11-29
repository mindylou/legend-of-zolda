open Ai
open Graphics
open Types

let getPlayerCommand () =
  let blank_command = {w = false;
                      a = false;
                      s = false;
                      d = false;
                      j = false;
                      k = false;
                      l = false} in
  let rec getKeys acc =
    match key_pressed () with
    | true -> getKeys ((Char.escaped (read_key ()) :: acc))
    | false -> acc in
  let keys = getKeys [] in
  let rec makeCommand k c =
    match k with
    | [] -> c
    | h :: t ->
      (match h with
       | "w" -> makeCommand t {c with w = true}
       | "a" -> makeCommand t {c with a = true}
       | "s" -> makeCommand t {c with s = true}
       | "d" -> makeCommand t {c with d = true}
       | "j" -> makeCommand t {c with j = true}
       | "k" -> makeCommand t {c with k = true}
       | "l" -> makeCommand t {c with l = true}
       | other -> makeCommand t c) in
  makeCommand keys blank_command

let getAiCommand st id = makeAiCommand st id
