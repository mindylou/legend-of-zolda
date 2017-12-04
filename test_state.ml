open OUnit2
open State
open Types
open Yojson.Basic.Util

let j = Yojson.Basic.from_file "start.json"
let q = Yojson.Basic.from_file "test.json"
let w = Yojson.Basic.from_file "test2.json"

let lst_to_tuple lst =
  if List.length lst = 2 then
    (float (List.nth lst 0), float (List.nth lst 1))
  else raise (Failure "invalid lst to tuple")



let check_spriteid st =
  st.id

let tests =
  [
    

]

let suite =
  "Legend test suite"
  >::: tests

let _ = run_test_tt_main suite
