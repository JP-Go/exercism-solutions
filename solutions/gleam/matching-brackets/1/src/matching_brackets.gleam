import gleam/list
import gleam/string
import gleam/result
import exercism/test_runner.{debug}
import gleam/pair
import gleam/dict

pub fn is_paired(value: String) -> Bool {
  let pairs = [#("(",")"), #("[","]"), #("{","}")]
  let openings = pairs |> list.map(pair.first) |> string.join("")
  let closings = pairs |> list.map(pair.second) |> string.join("")
  let contains_bracket = fn(x) { string.contains(openings,x) || string.contains(closings,x) }
  let delimiters = value 
      |> string.to_graphemes
      |> list.filter(contains_bracket)
      |> list.map(map_delimiter)
  let result = delimiters |> list.fold_until([],fn (acc,x) {
    case list.length(acc) == 0, x < 0 {
      True, True -> list.Stop([x])
      True, False -> list.Continue([x,..acc])
      False, True -> { 
        let assert [y, ..new_acc] = acc
        case y == -x {
            True -> list.Continue(new_acc)
            False -> list.Stop([x])
        } 
      }
      False, False -> list.Continue([x,..acc])
    }
  })
  list.is_empty(result)
}

fn map_delimiter(str: String) -> Int {
  case str {
    "(" -> 1
    "[" -> 2
    "{" -> 3
    ")" -> -1
    "]" -> -2
    "}" -> -3 
    _ -> 0
  }
}