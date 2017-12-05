open Types
open Helper
  
(* [getSprites sprites] parses a sprite list to
 * (my_sprite, player_sprite, other_sprites) *)
let getSprites st id =
  let all_sprites = st.all_sprites in
  let isEnemy (sprite: sprite) =
    match sprite.name with
    | Enemy _ -> true
    | Player -> false in
  let rec spriteList sprites me player other =
    match sprites with
    | []     -> (me, player, other)
    | h :: t ->
      if isEnemy h
      then
        if h.id = id
        then spriteList t (h :: me) player other
        else spriteList t me player (h :: other)
      else spriteList t me (h :: player) other in
  spriteList all_sprites [] [] []

let getSpriteLocations (sprites : sprite list) =
  List.fold_left
    (fun  (acc : location list) (s : sprite) -> s.location :: acc) [] sprites

let getDistance loc1 loc2 =
  let x1 = fst loc1.coordinate in
  let y1 = snd loc1.coordinate in
  let x2 = fst loc1.coordinate in
  let y2 = snd loc1.coordinate in
  let x_diff = x1 -. x2 in
  let y_diff = y1 -. y2 in
  sqrt (x_diff**2.0 +. y_diff**2.0)

(* [getDirection l1 l2] gives a direction from l1 to l2 as list of commands *)
let getDirection loc1 loc2 =
  let x1 = fst loc1.coordinate in
  let y1 = snd loc1.coordinate in
  let x2 = fst loc1.coordinate in
  let y2 = snd loc1.coordinate in
  let x = if x1 -. x2 > 0.0 then "a" else "d" in
  let y = if y1 -. y2 > 0.0 then "s" else "w" in
  [x; y]

(* [perpendicular xy_list] is a list of command keys giving a direction
 * perpendicular to xy_list *)
let perpendicular (xy_list: string list) =
  let x = List.hd xy_list in
  let y = List.hd (List.tl xy_list) in
  if Random.int 1 = 1
  then if x = "a" then ["d"; y] else ["a"; y]
  else if y = "s" then [x; "w"] else [x; "s"]

let blank_command =
  {w = false;
   a = false;
   s = false;
   d = false;
   j = false;
   k = false;
   l = false}

(* [makeCommand keys] makes a command with the keys list *)
let makeCommand k =
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
  makeCommand k blank_command

(* These functions make commands for different enemy types *)
let makeRandomCommand () =
  makeCommand
    (List.fold_left
    (fun acc l -> if Random.int 4 = 1 then l :: acc else acc)
    [] ["w";"a";"s";"d"])

let makeBlindCommand my_location player_location player_moving =
  if player_moving
  then makeCommand (getDirection my_location player_location)
  else makeRandomCommand ()

let makeCoopCommand my_location player_location other_locations =
  let direction_to_player = getDirection my_location player_location in
  let distance_to_player = getDistance my_location player_location in
  let min_distance_to_player =
    List.fold_left
      (fun acc other_loc -> max (getDistance player_location other_loc) acc)
      0.0 other_locations in
  if distance_to_player > min_distance_to_player
  then makeCommand direction_to_player
  else makeCommand (perpendicular direction_to_player)

let randomMoveChance m c =
  let move = Random.int c in
  if move = 0
  then m
  else "NONE"
  
let makeBossCommand my_location player_location my_size my_health =
  let direction_to_player = getDirection my_location player_location in
  let distance_to_player = getDistance my_location player_location in
  let my_health_percentage = fst my_health /. snd my_health in

  if distance_to_player > ceil (fst my_size *. 3.0)
  then makeCommand ((randomMoveChance "j" 10) :: direction_to_player)
  else if my_health_percentage < 0.5
  then makeCommand ((randomMoveChance "k" 1000) :: direction_to_player)
  else if Random.int 1 == 1
  then makeCommand direction_to_player
  else makeCommand (perpendicular direction_to_player)

(* [makeAiCommand st ai_id] returns the command for ai with id ai_id
 * during the current state st *)
let makeAiCommand st id =
  let sprites = getSprites st id in
  let my_sprite = List.hd (frst sprites) in
  let other_sprites = thrd sprites in
  let player_sprite = List.hd (scnd sprites) in

  let my_location = my_sprite.location in
  let player_location = player_sprite.location in
  let other_locations = getSpriteLocations other_sprites in

  let player_moving = player_sprite.moving in

  let my_size = my_sprite.size in

  let my_health = my_sprite.health in

  match my_sprite.name with
  | Player -> failwith "Called makeAiCommand on a Player"
  | Enemy enemy ->
    match enemy with
    | Random -> makeRandomCommand ()
    | Blind  -> makeBlindCommand my_location player_location player_moving
    | Coop   -> makeCoopCommand my_location player_location other_locations
    | Boss   -> makeBossCommand my_location player_location my_size my_health
