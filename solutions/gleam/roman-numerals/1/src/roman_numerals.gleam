import gleam/int
import gleam/list
import gleam/result
import gleam/string

const roman_tens = ["I","X","C","M"]
const roman_fives = ["V","L","D"]

pub fn convert(number: Int) -> String {
  let digits = int.digits(number,10) |> result.unwrap([]) |> list.reverse 
  digits |> list.index_map(with: fn (digit,idx) {
    case digit {
      i if i <= 3 -> string.repeat(get_tens(idx),i)
      i if i == 4 -> get_tens(idx) <> get_fives(idx)
      i if i <= 8 -> get_fives(idx) <> string.repeat(get_tens(idx), i - 5)
      _ -> get_tens(idx) <> get_tens(idx + 1) 
    }
  })
  |> list.reverse |> string.join("")
}

fn get_tens(index: Int) -> String {
  list.drop(roman_tens,index) |> list.first |> result.unwrap("")
}

fn get_fives(index: Int) -> String {
  list.drop(roman_fives,index) |> list.first |> result.unwrap("")
}
