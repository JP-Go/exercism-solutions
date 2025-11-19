import gleam/int
import gleam/list

pub fn convert(number: Int) -> String {
  let sounds = [#(3, "Pling"), #(5,"Plang"), #(7, "Plong")]
  sounds 
  |> list.map(with: fn(s) { case number % s.0 { 0 -> s.1 _ -> "" }})
  |> list.fold(from: "", with: fn(final, str) { final <> str })
  |> fn (f) {case f { "" -> int.to_string(number) _ -> f }}

}