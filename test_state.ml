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
  let initial_player = {
    id = 0;
    name = Player;
    action = Stand;
    size = (15., 15.);
    speed = 5.;
    location = {coordinate = (160., 160.); room = "start"};
    health = (100., 100.);
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
    max_count = 10;
    frame_count = 1;
    max_frame = 1;
    image = "sprites/spritesheet.png";
    has_won = false;
  }
  
  let init_enemy1 = {
    id = 1;
    name = Enemy Blind;
    action = Stand;
    size = (15., 15.);
    speed = 1.;
    location = {coordinate = (160., 140.); room = "start"};
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
    all_sprites = [initial_player; init_enemy1;];
    attack = (0.0,0.0), {coordinate = (0., 0.); room = "NONE"};
    (*  attack = (10.0,10.0), {coordinate = (26. *. 6., 26. *. 6. ); room = "start"}; *)
    has_won = false;
  
    all_rooms =
      [{room_id = "start"; width = 8.; height = 5.;
  
      obj_lst =
          [Portal { location = {coordinate = ( 26. *. 7., 7.*. 26.) ; room = "start"};
                    teleport_to = {coordinate = ( 26. *. 2., 6.*. 26.) ; room = "next"}};
  
           Obstacle {coordinate = ( 26. *. 4., 3.*. 26.) ; room = "start"};
           Obstacle {coordinate = ( 26. *. 4., 4.*. 26.) ; room = "start"};
           Obstacle {coordinate = ( 26. *. 4., 5.*. 26.) ; room = "start"};
           Obstacle {coordinate = ( 26. *. 4., 6.*. 26.) ; room = "start"};
           Obstacle {coordinate = ( 26. *. 4., 7.*. 26.) ; room = "start"};
          ]};
  
      {room_id = "next"; width = 6.; height = 6.;
        obj_lst =
          [         Texture {coordinate = ( 26. *. 5., 0.*. 26.) ; room = "next"};
                    Texture {coordinate = ( 26. *. 5., 1.*. 26.) ; room = "next"};
                    Texture {coordinate = ( 26. *. 5., 2.*. 26.) ; room = "next"};
                    Texture {coordinate = ( 26. *. 5., 3.*. 26.) ; room = "next"};
                    Texture {coordinate = ( 26. *. 5., 4.*. 26.) ; room = "next"};
                    Texture {coordinate = ( 26. *. 5., 5.*. 26.) ; room = "next"};
  
           Portal { location = {coordinate = ( 26. *. 2., 5.*. 26.) ; room = "next"};
                    teleport_to = {coordinate = ( 26. *. 7., 6.*. 26.) ; room = "start"}};
           End {coordinate = ( 26. *. 5., 6.*. 26.) ; room = "next"};
           Obstacle {coordinate = ( 26. *. 3., 1.*. 26.) ; room = "next"}
         ]}
      ];
    current_room_id = "start"}
let r1 = {room_id = "start"; width = 8.; height = 5.;

    obj_lst =
        [Portal { location = {coordinate = ( 26. *. 7., 7.*. 26.) ; room = "start"};
                  teleport_to = {coordinate = ( 26. *. 2., 6.*. 26.) ; room = "next"}};

         Obstacle {coordinate = ( 26. *. 4., 3.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 4., 4.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 4., 5.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 4., 6.*. 26.) ; room = "start"};
         Obstacle {coordinate = ( 26. *. 4., 7.*. 26.) ; room = "start"};
        ]}
let r2 = {room_id = "next"; width = 6.; height = 6.;
obj_lst =
  [         Texture {coordinate = ( 26. *. 5., 0.*. 26.) ; room = "next"};
            Texture {coordinate = ( 26. *. 5., 1.*. 26.) ; room = "next"};
            Texture {coordinate = ( 26. *. 5., 2.*. 26.) ; room = "next"};
            Texture {coordinate = ( 26. *. 5., 3.*. 26.) ; room = "next"};
            Texture {coordinate = ( 26. *. 5., 4.*. 26.) ; room = "next"};
            Texture {coordinate = ( 26. *. 5., 5.*. 26.) ; room = "next"};

   Portal { location = {coordinate = ( 26. *. 2., 5.*. 26.) ; room = "next"};
            teleport_to = {coordinate = ( 26. *. 7., 6.*. 26.) ; room = "start"}};
   End {coordinate = ( 26. *. 5., 6.*. 26.) ; room = "next"};
   Obstacle {coordinate = ( 26. *. 3., 1.*. 26.) ; room = "next"}
 ]}
let st = initial_state
let check_spriteid st =
  st.id

let tests =
  [
    "not_win" >:: (fun _ -> assert_equal false st.has_won);
    "correct_sprites" >:: (fun _ -> assert_equal [initial_player; init_enemy1] st.all_sprites);
    "correct_start_room" >:: (fun _ -> assert_equal "start" st.current_room_id);
    "all_rooms" >:: (fun _ -> assert_equal [r1; r2] st.all_rooms)
]

let suite =
  "Legend test suite"
  >::: tests

let _ = run_test_tt_main suite
