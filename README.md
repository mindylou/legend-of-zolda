# Legend of ZO(Caml)lda

![screenshot](https://github.com/mindylou/legend-of-tomnjam/blob/master/styles/screenshot.png)

## Description
You, the user, will take on the role of the protagonist, Lonk, and will need to travel through the 
map, fend off countless terrifying enemies, and defeat the final boss to save Zolda and the world of Tomnjam. You will not have an easy time navigating your way through this journey; however, you will learn to explore beautiful landscapes, encounter exotic beasts (that you’ll most likely have to kill), and attain glory and riches all within the comfort of your bed. This is an easily accessible Web-based game that you can quickly enjoy between slides in lecture or when your Youtube video is buffering.

## How to Run
OCaml and Opam must be installed. 

Prerequisites:
`opam install js_of_ocaml js_of_ocaml-ocamlbuild js_of_ocaml-camlp4 js_of_ocaml-lwt`

Run:
`make` and open `index.html`

## Key Features
- Interactive Web-based GUI
- Portals to move between rooms
- Enemies with different speeds, attacks, AI, and health
- Kill count and health
- Final boss

## System Design
### Modules: 

#### State
This module records the status of the game at any given time. This will allow the game to be run continuously, and updates for each move or change to the state, such as movement. This acts as the model of the model-view-controller design.

#### Command
This module contains the functions needed to let a user play the game, as well as calling the AI for move inputs. The AI will input commands exactly like the player for code reusability, in this way adding additional enemy types or players would be very easy.

#### GUI
This module contains the code necessary for the visual implementation of the backend and will update to reflect visual changes in the state. This acts as the view of the MVC design.

#### Game
This module executes the game loop and calls updates to state and drawing based on the player inputs. This acts as the controller of the MVC design. 

#### Main
This module runs the game by calling the necessary Javascript animation functions. It calls the game loop and adds the canvas and basic HTML elements to the page.

#### AI
This module contains functions that allow enemies to act autonomously and attack the user’s character. It will provide commands in a fashion to emulate key inputs.

#### Room/Sprites
These modules contain the parameters to instantiate the initial player, map, and enemies.

## Division of Labor:
In general, Julian and Alex worked on the backend while Mindy and Tom worked on the frontend. More detail is provided below.
- Julian: Primarily worked on design and State. He spent ~40 hours on this project.
- Alex: Primarily worked on design and the AI, as well as implementing the ai-portion of command, and some of the functionality in State. He spent ~35 hours on this project.
- Tom: Worked on design, GUI, main, game, and state files as well as crafting levels, specifically implementing Json design and parsing for state (which was removed because of unfortunate compatibility issues with js_of_ocaml), sprite animation, and map parsing/design. He spent ~45 hours on this project. The commits on Github are not representative due to issues with the VM and general laptop problems. He worked mainly through Mindy’s laptop and Github account for the 2nd half of game development. 
- Mindy: Worked on design, the GUI, main, game, and state files as well as crafting levels, specifically on the drawing functions in GUI and the game loop. She spent ~42 hours on this project. 

## Module Design
See the .mli files for the full specifications on the modules.
We designed each interface file to contain and expose the most pertinent information that the other files will need to access. The types and helper files contain all of the types contained in the game and some simple helper functions respectively. The state contains a model of the game state, command contains a type to represent command input keys, as well as ways to retrieve those keys from either the player or the AI. AI contains an accessible function that allows a command to be made for an AI in the given state. Rooms and sprites files contain information about the initial state of the game. Originally the game's initial state was to be represented as a json for ease of map/game development. This would also allow for easy saving/restarting of game states. The code was written but unfortunately abandoned to a compatibility issues regarding yojson with js_of_ocaml and JavaScript.

The state contains all of the information about the game, such as the sprites (including the player), all rooms, all objects, the attack location, and the current room.

The command file contains a mutable record that updates based on the user input from the keyboard and parses it to match a command type defined. The command types represent the keys pressed, such as w, a, s, d, j.
The GUI module contains all of the code and functions that render and display the content of the game state on screen for the user to see through HTML, CSS, and JavaScript converted from OCaml. Functions in Gui.ml include methods to cycle through sprite sheets, match specific images to room records, create a DOM for web display, and more. The Game module contains functions required for sprite animation, game looping, and listeners for browser key commands. Moreover the initial maps, sprites, obstacles, textures, enemy sprites, weapons, and entrances and exits to other rooms are congregated into the beginning state of the game in this module.  The room and sprite modules contain the actual records for rooms and sprites with the necessary starting parameters to remove noise from the game module. 

### AI
The AI module consists of four types of enemies with all of the extensibility of the player sprites (since all sprites are represented with the same type in the game’s backend). This means that the enemy sprites can use moves just as the player sprite does, as well as have adjustable health, speed, size, actions, etc. The four types of enemies currently are as follows:

- Stationary: This is a simple AI who approaches the player aggressively until it reaches a certain distance, then stops. It is really a moving statue made to resemble an evil the world hasn’t witnessed in eons…
- Blind: These enemies are unable to detect the player location unless the player is moving (making noise), because of this they remain stationary unless the player is moving, in which case they approach the character one step at a time. If the enemy does get close enough it will be able to hear the player breathing, and it will attack aggressively.
- Coop: These enemies are unique in that their actions depend on the other enemies on the map. These enemies do not like to attack alone, so instead they work together. If a Coop enemy is alone facing a player they will wait for other enemies to come to their aid before approaching. Because of this, these enemies can be manipulated into approaching very slowly if a Blind enemy is nearby. Coop enemies are also able to fly over obstacles such as trees.
- Boss: The boss enemy is the only one who is able to use moves. In the current game implementation it also is the enemy with the most health. The Boss’s moves do not consist of physical objects such as the player’s sword, instead they act as attribute buffs. While the boss begins quite slow it has the ability to randomly increase its speed if the player is far enough away. In addition, the boss is able to transform once it’s heath gets below 50%. In this new form the boss is able to permanently increase its attack radius. Both of these moves make it important to kill the boss quickly. The boss is also able to fly over obstacles. 

## Data
The State module maintains data on locations, actions, and types of AI enemies present on the map along with the location and actions of the sprites. Data containing the sprite’s name, health, location, speed, and animation parameters will also be maintained throughout the duration of the game. This data is stored in the form of records where each entity will have their respective fields that can be altered based on the actions of AI and the user. The data containing the map and sprites is stored in various lists. The three maps used were designed on paper before being hardcoded into a map type. 

## External Dependencies
For the GUI, Oscigen’s js_of_ocaml library was incorporated  to translate OCaml code to browser-based Javascript for accessibility. 

## Acknowledgements:
The sprite sheets we used are from wiizelda.net and WWCZ.info, and we referenced [MariOCaml](https://github.com/mahsu/MariOCaml), a fall 2015 CS 3110 project, for our GUI and animation code. The audio is taken from [YouTube](https://www.youtube.com/watch?v=scicO4v8d3M). The font used in the game is Triforce, and is from DarkAngelX on DeviantArt. All rights go to their respective creators. 

## Authors:
This was built for Cornell University's CS 3110 Fall 2017 final project and was built by:
- Thomas Chen [@trchen19](https://github.com/trchen19)
- Julian Massarani [@jmassarani](https://github.com/jmassarani)
- Alex Sabia [@as2633](https://github.com/as2633)
- Mindy Lou [@mindylou](https://github.com/mindylou)

