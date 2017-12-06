open OUnit2
open State
open Types
open Ai

let standing_player = {
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
    offset = (0., 0.);};
  counter = 0;
  max_count = 10;
  frame_count = 1;
  max_frame = 1;
  image = "sprites/spritesheet.png";
  has_won = false;
}

let moving_player = {standing_player with moving = true;
                                          id     = 1}

let blind_enemy = {
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
    offset = (133., 91.);};
  counter =  0;
  max_count = 0;
  frame_count =  0;
  max_frame = 1;
  image = "sprites/enemysprites.png";
  has_won = false;
}
let coop_enemy = {blind_enemy with name = Enemy Coop;
                                   id   = 3}

let boss_enemy = {blind_enemy with name = Enemy Boss;
                                   id   = 4}

(* states *)
let moving_player_blind_enemy = {
  all_sprites = [moving_player; blind_enemy];
  attack = (0.0,0.0), {coordinate = (0., 0.); room = "NONE"};
  has_won = false;
  all_rooms =
    [{room_id = "start"; width = 8.; height = 5.;
      obj_lst =
        [End {coordinate = (2., 7.); room = "start"};
         Obstacle {coordinate = (4., 0.); room = "start"};
         Texture {coordinate = (2., 6.); room = "start"};
         Portal {location =
                   {coordinate = (1.,1.); room = "start"};
                 teleport_to =
                   {coordinate = (1.,1.); room = "start"}}]}];
  current_room_id = "start"}

let blank_command =
  {w = false;
   a = false;
   s = false;
   d = false;
   j = false;
   k = false;
   l = false}

let left_command = {blank_command with a = true}

let tests =
  [
    "blind_attack" >::
    (fun _ -> assert_equal left_command
        (makeAiCommand moving_player_blind_enemy 2));
  ]

let suite =
  "Legend test suite"
  >::: tests

let _ = run_test_tt_main suite
