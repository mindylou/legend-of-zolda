open Types

let player = {
  id = 0;
  name = Player;
  action = Stand;
  size = (10., 10.);
  speed = 8.;
  location = {coordinate = (2.*.26., 0.); room = "start"};
  health = (100., 100.);
  kill_count = 0;
  direction = South;
  moves = [{id = "sword"; unlocked = true; frame = 5}];
  moving = false;
  params = {
    img = "sprites/spritesheet.png";
    frame_size = (20., 20.);
    offset = (0., 0.);
  };
  counter = 0;
  max_count = 10;
  frame_count = 1;
  max_frame = 1;
  image = "sprites/spritesheet.png";
  has_won = false;
}

let enemy1 = {
  id = 1;
  name = Enemy Blind;
  action = Stand;
  size = (15., 15.);
  speed = 1.;
  location = {coordinate = (26.*.2., 26.*.3.); room = "start"};
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

let enemy_stationary = {enemy1 with name = Enemy Random}

let enemy2 = {enemy1 with location = {coordinate = (26. *. 6., 8. *. 26.);
                                            room = "room1";};
                          id = 2}



let enemy3 =
  {enemy1 with location = {coordinate = (26. *. 6., 4. *. 26.);
                                room = "room1";};
                    id = 3}

let enemy4 =
  {enemy1 with location = {coordinate = (26. *. 10., 6. *. 26.);
                                room = "room1";};
                    id = 4}

let enemy5 =
  {enemy1 with location = {coordinate = (26. *. 14., 4. *. 26.);
                                room = "room1";};
                    id = 5;
                    name = Enemy Coop}

let enemy6 =
  {enemy1 with location = {coordinate = (26. *. 20., 12. *. 26.);
                           room = "room2";};
                    id = 6;
                    name = Enemy Coop}

let enemy7 =
  {enemy1 with location = {coordinate = (26. *. 20., 15. *. 26.);
                           room = "room2";};
                    id = 7;
                    name = Enemy Coop}

let enemy8 =
  {enemy1 with location = {coordinate = (26. *. 22., 3. *. 26.);
                           room = "room2";};
                    id = 8;
               name = Enemy Coop}

let enemy9 =
  {enemy1 with location = {coordinate = (26. *. 22., 20. *. 26.);
                           room = "room2";};
               id = 9;
               name = Enemy Coop}

let enemy10 =
  {enemy1 with location = {coordinate = (26. *.22., 9. *. 26.);
                           room = "room2";};
               id = 10;
               name = Enemy Coop}

let enemy11 =
  {enemy1 with location = {coordinate = (26. *. 19., 1. *. 26.);
                           room = "room2";};
               id = 11;
               name = Enemy Coop}

let enemy12 =
  {enemy1 with location = {coordinate = (26. *. 23., 21. *. 26.);
                           room = "room2";};
               id = 12;
               name = Enemy Coop}

let enemy13 =
  {enemy1 with location = {coordinate = (26. *. 24., 4. *. 26.);
                           room = "room2";};
               id = 13;
               name = Enemy Coop}

let enemy14 =
  {enemy1 with location = {coordinate = (26. *. 24., 15. *. 26.);
                           room = "room2";};
               id = 14;
               name = Enemy Coop}

let enemy15 =
  {enemy1 with location = {coordinate = (26. *. 24., 2. *. 26.);
                           room = "room2";};
               id = 15;
               name = Enemy Coop}

let enemy16 =
  {enemy1 with location = {coordinate = (26. *. 27., 9. *. 26.);
                           room = "room2";};
               id = 16;
               name = Enemy Boss;
               health = (100., 100.);
               speed = 0.5;
  }

let enemy17 =
  {enemy1 with location = {coordinate = (24.*.26., 12.*.26.); room = "room2"};
               id = 17}
