type id = int

type enemy_type = Blind | Coop | Boss

type sprite_type = Enemy of enemy_type | Player

type move =
  {
    id: string;
    unlocked: bool;
    frame: int
  }

type location =
  {
    coordinate: float * float;
    room: string;
  }

type direction = North | South | East | West

type sprite =
  {
    id: int;
    name: sprite_type;
    is_enemy: bool;
    size: int;
    speed: int;
    location: location;
    health: int;
    kill_count: int;
    direction: direction;
  }

type moves = move list

type portal =
  {
    location: location;
    teleport_to: location;
  }

type obj_type =
  | Portal of portal
  | Texture
  | Obstacle

type obj =
  {
    obj_type: obj_type;
    location: location;
  }

type square_type =
  Obj of obj | Sprite of sprite

type square =
  {
    square_type: square_type;
    location: location;
  }
type state =
  {
    player_location: location;
    all_sprites: sprite list;
    player_health: int;
    has_won: bool;
    player_kc: int;
    all_rooms: string list;
    all_objects: obj list;
    current_room_id: string;
  }


type command = {w: bool;
                a: bool;
                s: bool;
                d: bool;
                j: bool;
                k: bool;
                l: bool}
