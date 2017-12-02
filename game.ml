open Types

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

let init_loc = {
  coordinate = (0., 0.);
  room = "room"
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

let x = ref 0.
let y = ref 0.
let img_src = ref "sprites/front.png"

let keydown event =
  let () = match event##keyCode with
    | 87 -> y := !y -. 1.; img_src := "sprites/back.png"
    | 65 -> x := !x -. 1.; img_src := "sprites/left.png"
    | 83 -> y := !y +. 1.; img_src := "sprites/front.png"
    | 68 -> x := !x +. 1.; img_src := "sprites/right.png"
    | _ -> () (* other *)
  in Js._true

let keyup event =
  let () = match event##keyCode with
    | 87 -> player_command.w <- false
    | 65 -> player_command.a <- false
    | 83 -> player_command.s <- false
    | 68 -> player_command.d <- false
    | 74 -> player_command.j <- false
    | 75 -> player_command.k <- false
    | 76 -> player_command.l <- false
    | _ -> () (* other *)
  in Js._true

let json_to_init_state f =
  let j = try Yojson.Basic.from_file f with json_error -> failwith "Bad file" in
  State.init_state j

let game_loop context has_won =
  let rec game_loop_helper () =
    Gui.clear context;
    Gui.draw_image_on_context context (js !img_src ) (!x, !y);
    Html.window##requestAnimationFrame(
      Js.wrap_callback (fun (t:float) -> game_loop_helper ())
    ) |> ignore
  in game_loop_helper ()
