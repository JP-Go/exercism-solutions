import gleam/int
import gleam/list

type Divisor = Int
type Sound = String

pub fn convert(number: Int) -> String {
  let sounds = [#(3, "Pling"), #(5,"Plang"), #(7, "Plong")]
  sound_divisor(sounds)(number)
}

fn sound_divisor(sounds: List(#(Divisor,Sound))) -> fn (Int) -> Sound {
  fn (n) {
    sounds 
    |> list.map(with: fn(s) { case n % s.0 { 0 -> s.1 _ -> "" }})
    |> list.fold(from: "", with: fn(final, str) { final <> str })
    |> fn (f) {case f { "" -> int.to_string(n) _ -> f }}
  }
}