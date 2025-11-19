import gleam/int
import gleam/string

pub fn convert(number: Int) -> String {
  let pling = case number % 3 { 0 -> "Pling" _ -> "" }
  let plang = case number % 5 { 0 -> "Plang" _ -> "" }
  let plong = case number % 7 { 0 -> "Plong" _ -> "" }
  let final = pling <> plang <> plong
  case string.is_empty(final) {
    True -> int.to_string(number)
    _ -> final
  }
}
