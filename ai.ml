(*open Types
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

let getMySprite st id =
  failwith "Unimplemented"

let makeBlindCommand st =
  failwith "Unimplimented"

let makeCoopCommand st =
  failwith "Unimplimented"

let makeBossCommand st =
  failwith "Unimplimented"

let makeAiCommand st id =
  let sprites = getSprites st id in
  let my_sprite = List.hd (frst sprites) in
  let other_sprites = thrd sprites in
  let player_sprite = List.hd (scnd sprites) in

  let my_location = my_sprite.location in
  let player_location = player_sprite.location in
  let other_locations = getSpriteLocations other_sprites in

  
  failwith "Unimplimented"
*)

let makeAiCommand st id =
  failwith "Unimplimented"
