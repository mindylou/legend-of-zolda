(*
open Types

(* returns (myLocation, otherEnemyLocations) *)
let getEnemySprites st id =
  let all_sprites = st.all_sprites in
  let isEnemy (sprite: sprite) =
    match sprite.name with
    | Enemy -> true
    | Player -> false in
  let rec spriteList sprites acc1 acc2 =
    match sprites with
    | []     -> (acc1, acc2)
    | h :: t ->
      if isEnemy h && h.id = id
      then spriteList t (h :: acc1) acc2
      else spriteList t acc1 (h :: acc2) in
  spriteList all_sprites [] []

let getMySprite st id =
  failwith "Unimplemented"

let makeBlindCommand st =
  failwith "Unimplimented"

let makeCoopCommand st =
  failwith "Unimplimented"

let makeBossCommand st =
  failwith "Unimplimented"

let makeAiCommand st id =
  let enemy_locations = getEnemyLocations st id in
  let my_location = fst enemy_locations in
  let other_enemy_locations = snd enemy_locations in
  match



  failwith "Unimplimented"
*)

let makeAiCommand st id = failwith "Unimplimented"


