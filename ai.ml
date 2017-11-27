open Types

(* returns (myLocation, otherEnemyLocations) *)
let getEnemyLocations st id =
  let all_sprites = st.all_sprites in
  let isEnemy sprite =
    match sprite.name with
    | Enemy -> true
    | Player -> false in
  let rec locationsList sprites acc1 acc2 =
    match sprites with
    | []     -> (acc1, acc2)
    | h :: t ->
      if isEnemy h && h.id = id
      then locationsList t (h.location :: acc1) acc2
      else locationsList t acc1 (h.location :: acc2) in
  locationsList all_sprites [] []

let getMySprite st id =
  

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
