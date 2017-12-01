type id = int

type enemy_type = Random | Blind | Coop | Boss

type sprite_type = Enemy of enemy_type | Player

type move =
  {
    id: string;
    unlocked: bool;
    frame: int;
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
    size: (float*float);
    speed: int;
    location: location;
    health: int;
    kill_count: int;
    direction: direction;
    moves: move list;
    moving: bool;
  }


type portal =
  {
    location: location;
    teleport_to: location;
  }

type obj =
  | Portal of portal
  | Texture of location
  | Obstacle of location
  | End of location


type room =
  {
    room_id: string;
    width: float;
    height: float;
    obj_lst: obj list;
  }

type state =
  {
    all_sprites: sprite list;
    has_won: bool;
    all_rooms: room list;
    current_room_id: string;
  }


type command = {w: bool;
                a: bool;
                s: bool;
                d: bool;
                j: bool;
                k: bool;
                l: bool}
