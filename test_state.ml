open OUnit2
open State

let j = Yojson.Basic.from_file "start.json"


let tests =
[
  "has_won" >:: (fun _ -> assert_equal true (j |> init_state |> get_has_won));
  "curr_room" >:: (fun _ -> assert_equal "start" (j |> init_state |> get_curr_room));
  (* "score" >:: (fun _ -> assert_equal 10001 (j|> init_state |> score));
  "turns" >:: (fun _ -> assert_equal 0 (j|> init_state |> turns));
  "curr_room" >:: (fun _ -> assert_equal "room1" (j |> init_state |> current_room_id));
  "inv" >:: (fun _ -> assert_equal ["white hat"] (j |> init_state |> inv));
  "visited" >:: (fun _ -> assert_equal ["room1"] (j |> init_state |> visited));
  "locations" >:: (fun _-> assert_equal [("key", "room2"); ("red hat", "room1");
                                         ("black hat", "room1")] (j |> init_state |> locations)); *)
]

let suite =
  "Legend test suite"
  >::: tests

let _ = run_test_tt_main suite
