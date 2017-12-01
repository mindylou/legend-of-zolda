open Types
open Helper
  
(* returns (myLocation, otherEnemyLocations) *)
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

let getDirection loc1 loc2 =
  let x1 = fst loc1.coordinate in
  let y1 = snd loc1.coordinate in
  let x2 = fst loc1.coordinate in
  let y2 = snd loc1.coordinate in
  let x = if x1 -. x2 > 0.0 then "a" else "d" in
  let y = if y1 -. y2 > 0.0 then "s" else "w" in
  [x; y]

let blank_command =
  {w = false;
   a = false;
   s = false;
   d = false;
   j = false;
   k = false;
   l = false}

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

let makeRandomCommand () =
  makeCommand
    (List.fold_left
    (fun acc l -> if Random.int 1 == 1 then l :: acc else acc)
    ["w";"a";"s";"d";"j";"k";"l"] [])
    
let makeBlindCommand my_location player_location player_moving =
  if player_moving
  then makeCommand (getDirection my_location player_location)
  else makeRandomCommand ()

let makeCoopCommand my_location player_location other_location =
  failwith "Unimplimented"

let makeBossCommand my_location player_location =
  failwith "Unimplimented"

let makeAiCommand st id =
  let sprites = getSprites st id in
  let my_sprite = List.hd (frst sprites) in
  let other_sprites = thrd sprites in
  let player_sprite = List.hd (scnd sprites) in

  let my_location = my_sprite.location in
  let player_location = player_sprite.location in
  let other_locations = getSpriteLocations other_sprites in

  let player_moving = player_sprite.moving in

  match my_sprite.name with
  | Player -> failwith "Called makeAiCommand on a Player"
  | Enemy enemy ->
    match enemy with
    | Random -> makeRandomCommand ()
    | Blind  -> makeBlindCommand my_location player_location player_moving
    | Coop   -> makeCoopCommand my_location player_location other_locations
    | Boss   -> makeBossCommand my_location player_location
