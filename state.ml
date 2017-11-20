
type state =
  {
    player_location: location;
    all_sprites: sprite list;
    player_health: int;
    has_won: bool;
    player_kc: int;
    all_rooms: string list;
    all_objects: obj list;
  }

let distance_btwn (x1,y1) (x2,y2) = 
  sqrt ((x1 -. x2) ** 2. +. (y1 -. y2) ** 2.)
  