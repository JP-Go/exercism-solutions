import gleam/string
import gleam/list
import gleam/order

pub fn is_pangram(sentence: String) -> Bool {
  string.lowercase(sentence) 
  |> string.split("")
  |> list.filter(fn(x) {
    order.break_tie(string.compare(x,"a"),order.Gt) == order.Gt
    && order.break_tie(string.compare(x,"z"),order.Lt) == order.Lt
  })
  |> list.unique
  |> list.length == 26
}
