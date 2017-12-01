open Ai
open Graphics
open Types

type command = {
  mutable w : bool;
  mutable a : bool;
  mutable s : bool;
  mutable d : bool;
  mutable j : bool;
  mutable k : bool;
  mutable l : bool;
}

let player_command = {
  w = false;
  a = false;
  s = false;
  d = false;
  j = false;
  k = false;
  l = false;
}

let ai_command = {
  w = false;
  a = false;
  s = false;
  d = false;
  j = false;
  k = false;
  l = false;
}
