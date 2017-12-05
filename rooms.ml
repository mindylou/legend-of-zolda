open Types

let start = {room_id = "start";
             width = 8.;
             height = 5.;
             obj_lst =
               [Portal { location = {coordinate = ( 26. *. 6., 7.*. 26.);
                                     room = "start"};
                         teleport_to = {coordinate = ( 26. *. 1., 4.*. 26.);
                                        room = "room1"}};

                Obstacle {coordinate = ( 26. *. 8., 0.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 8., 1.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 8., 2.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 8., 3.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 8., 4.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 8., 5.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 8., 6.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 8., 7.*. 26.) ; room = "start"};

                (* Obstacle {coordinate = ( 26. *. 5., 5.*. 26.) ; room = "start"}; *)

                Obstacle {coordinate = ( 26. *. 4., 0.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 4., 1.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 4., 2.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 4., 3.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 4., 4.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 4., 5.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 4., 6.*. 26.) ; room = "start"};
                Obstacle {coordinate = ( 26. *. 4., 7.*. 26.) ; room = "start"};

                Texture {coordinate = ( 26. *. 5., 0.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 5., 1.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 5., 2.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 5., 3.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 5., 4.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 5., 5.*. 26.) ; room = "start"};

                Texture {coordinate = ( 26. *. 5., 6.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 7., 7.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 6., 0.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 6., 1.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 6., 2.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 6., 3.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 6., 4.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 6., 5.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 6., 6.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 5., 7.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 7., 0.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 7., 3.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 7., 1.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 7., 2.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 7., 4.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 7., 5.*. 26.) ; room = "start"};
                Texture {coordinate = ( 26. *. 7., 6.*. 26.) ; room = "start"}]
            }

let room1 = {room_id = "room1";
             width = 20.;
             height = 12.;
             obj_lst =
               [
                 Texture {coordinate = ( 26. *. 0., 9.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 0., 1.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 0., 2.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 0., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 0., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 0., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 0., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 0., 8.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 1., 1.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 1., 2.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 1., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 1., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 1., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 1., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 1., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 1., 8.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 2., 1.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 2., 2.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 2., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 2., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 2., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 2., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 2., 7.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 3., 2.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 3., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 3., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 3., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 3., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 3., 7.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 4., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 4., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 4., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 4., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 4., 8.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 5., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 5., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 5., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 5., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 5., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 5., 8.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 5., 9.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 6., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 6., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 6., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 6., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 6., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 6., 8.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 6., 9.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 7., 2.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 7., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 7., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 7., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 7., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 7., 8.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 7., 9.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 8., 2.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 8., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 8., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 8., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 8., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 8., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 8., 8.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 8., 9.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 8., 1.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 9., 2.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 9., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 9., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 9., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 9., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 9., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 9., 8.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 9., 9.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 9., 1.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 10., 2.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 10., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 10., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 10., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 10., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 10., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 10., 8.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 10., 9.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 10., 1.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 11., 2.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 11., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 11., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 11., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 11., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 11., 8.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 12., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 12., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 12., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 12., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 12., 7.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 13., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 13., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 13., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 13., 7.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 14., 2.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 14., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 14., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 14., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 14., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 14., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 14., 8.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 15., 2.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 15., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 15., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 15., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 15., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 15., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 15., 8.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 15., 9.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 15., 1.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 16., 2.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 16., 3.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 16., 4.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 16., 5.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 16., 6.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 16., 7.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 16., 8.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 16., 9.*. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 16., 1.*. 26.) ; room = "room1"};

                 Texture {coordinate = ( 26. *. 17., 2. *. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 17., 3. *. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 17., 4. *. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 17., 5. *. 26.) ; room = "room1"};
                 Texture {coordinate = ( 26. *. 17., 6. *. 26.) ; room = "room1"};

                 Obstacle {coordinate = ( 26. *. 0., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 1., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 2., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 3., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 4., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 5., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 6., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 7., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 8., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 9., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 10., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 11., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 12., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 13., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 14., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 15., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 16., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 17., 0.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 18., 0.*. 26.) ; room = "room1"};

                 Obstacle {coordinate = ( 26. *. 3., 1.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 4., 1.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 5., 1.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 6., 1.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 7., 1.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 11., 1.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 12., 1.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 13., 1.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 14., 1.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 17., 1.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 18., 1.*. 26.) ; room = "room1"};

                 Obstacle {coordinate = ( 26. *. 4., 2.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 5., 2.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 6., 2.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 12., 2.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 13., 2.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 18., 2.*. 26.) ; room = "room1"};

                 Obstacle {coordinate = ( 26. *. 4., 4.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 11., 4.*. 26.) ; room = "room1"};

                 Obstacle {coordinate = ( 26. *. 18., 3.*. 26.) ; room = "room1"};

                 Obstacle {coordinate = ( 26. *. 18., 5.*. 26.) ; room = "room1"};

                 Obstacle {coordinate = ( 26. *. 7., 6.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 13., 6.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 18., 6.*. 26.) ; room = "room1"};

                 Obstacle {coordinate = ( 26. *. 17., 7.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 18., 7.*. 26.) ; room = "room1"};

                 Obstacle {coordinate = ( 26. *. 2., 8.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 3., 8.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 12., 8.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 13., 8.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 17., 8.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 18., 8.*. 26.) ; room = "room1"};

                 Obstacle {coordinate = ( 26. *. 1., 9.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 2., 9.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 3., 9.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 4., 9.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 11., 9.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 12., 9.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 13., 9.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 14., 9.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 17., 9.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 18., 9.*. 26.) ; room = "room1"};

                 Obstacle {coordinate = ( 26. *. 0., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 1., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 2., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 3., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 4., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 5., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 6., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 7., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 8., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 9., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 10., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 11., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 12., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 13., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 14., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 15., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 16., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 17., 10.*. 26.) ; room = "room1"};
                 Obstacle {coordinate = ( 26. *. 18., 10.*. 26.) ; room = "room1"};

                 Portal { location = {coordinate = ( 26. *. 0., 4.*. 26.) ; room = "room1"};
                          teleport_to = {coordinate = ( 26. *. 7., 6.*. 26.) ; room = "start"}};
                 Portal { location = {coordinate = ( 26. *. 18., 4.*. 26.) ; room = "room1"};
                          teleport_to = {coordinate = ( 26. *. 1., 10q  ww.*. 26.) ; room = "room2"}};
               ]
            }
