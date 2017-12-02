open OUnit2
open State
open Types
open Yojson.Basic.Util

let j = Yojson.Basic.from_file "start.json"
let q = Yojson.Basic.from_file "test.json"
let w = Yojson.Basic.from_file"test2.json"

let lst_to_tuple lst =
  if List.length lst = 2 then
    (float (List.nth lst 0), float (List.nth lst 1))
  else raise (Failure "invalid lst to tuple")

let moves_of_json j =
  {
    id = j |> member "id" |> to_string;
    unlocked = j |> member "unlocked" |> to_bool;
    frame = j |> member "frame" |> to_int;
  }

let loc_of_json j =
  let coordinate_tup = j |> member "coordinate" |> to_list |> filter_int in
  {
    coordinate = lst_to_tuple coordinate_tup;
    room = j |> member "room" |> to_string;
  }

let portal_of_json j =
  {
    location = j |> member "from" |> loc_of_json;
    teleport_to = j |> member "to" |> loc_of_json;
  }

let dir_of_json j =
  let d = j |> member "direction" |> to_string in
  match d with
  | "North" -> North
  | "West" -> West
  | "East" -> East
  | "South" -> South
  | _ -> raise (Failure "invalid location")

let obj_of_json j =
  let obj_type = j |> member "type" |> to_string in
  match obj_type with
  | "End" -> End (loc_of_json j)
  | "Obstacle" -> Obstacle (loc_of_json j)
  | "Texture" -> Texture (loc_of_json j)
  | "Portal" -> Portal (portal_of_json j)
  | _ -> raise (Failure "Invalid object in Json")

let room_of_json j =
  {
    room_id = j |> member "id" |> to_string;
    width = j |> member "width" |> to_float;
    height = j |> member "height" |> to_float;
    obj_lst = j |> member "objects" |> to_list |> List.map obj_of_json;
  }


let sprite_of_json j =
  let size_tup = j |> member "size" |> to_list |> filter_int in
  let sprite_id = j |> member "id" |> to_int in
  {
    id = sprite_id;
    name = (if sprite_id = 0 then Player else Enemy Blind);
    is_enemy = j |> member "is_enemy" |> to_bool;
    size = lst_to_tuple size_tup;
    speed = j |> member "speed" |> to_int;
    location = j |> loc_of_json;
    health = (j |> member "health" |> to_float, j |> member "health" |> to_float);
    kill_count = j |> member "kill_count" |> to_int;
    direction = j |> dir_of_json;
    moves = j |> member "moves" |> to_list |> List.map moves_of_json;
    moving = j |> member "moving" |> to_bool;
  }

let check_spriteid st =
  st.id

let tests =
  [
    "sprite_id" >:: (fun _ -> assert_equal 0 (q |> member "id" |> to_int));
    "is_enemy" >:: (fun _ -> assert_equal false (q |> member "is_enemy" |> to_bool));
    "size" >:: (fun _ -> assert_equal (1., 1.) (q |> member "size" |> to_list |> filter_int |> lst_to_tuple));
    "spped" >:: (fun _ -> assert_equal 1 (q |> member "speed" |> to_int));
    "location" >:: (fun _ -> assert_equal {coordinate = (0.,2.); room = "start";} (q |> member "location" |> loc_of_json));
    "direction" >:: (fun _ -> assert_equal East (q |> dir_of_json));
    "moves" >:: (fun _ -> assert_equal [{id = "sword"; unlocked = true; frame = 5;}]
                    (q |> member "moves" |> to_list |> List.map moves_of_json));
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
