import gleam/dict.{type Dict}
import gleam/option.{Some,None}
import gleam/string
import gleam/list

fn is_alphanumeric_codepoint(codepoint: UtfCodepoint) -> Bool {
  let i = string.utf_codepoint_to_int(codepoint)
  string.utf_codepoint_to_int(codepoint) >= 48 && string.utf_codepoint_to_int(codepoint) <= 57 // number
  || string.utf_codepoint_to_int(codepoint) >= 65 && string.utf_codepoint_to_int(codepoint) <= 90 // uppercase letter
  || string.utf_codepoint_to_int(codepoint) >= 97 && string.utf_codepoint_to_int(codepoint) <= 122 // lowercase letter
}

fn is_quote(codepoint: UtfCodepoint) -> Bool {
  string.utf_codepoint_to_int(codepoint) == 34 || string.utf_codepoint_to_int(codepoint) == 39 // single or double quotes
}

fn replace_symbols_with_spaces(codepoints: List(UtfCodepoint), result: List(UtfCodepoint)) -> List(UtfCodepoint) {
  let assert Ok(space) = string.utf_codepoint(32)
  case codepoints {
    [] -> list.reverse(result)
    [a,..rest] -> case is_alphanumeric_codepoint(a) || is_quote(a) {
      True -> replace_symbols_with_spaces(rest,[a,..result])
      _ -> replace_symbols_with_spaces(rest,[space,..result])
    }
  }
}

fn clean_input(input: String) -> String {
  input
  |> string.to_utf_codepoints
  |> replace_symbols_with_spaces([])
  |> string.from_utf_codepoints
}

fn trim_quotes_start(word: String) -> String {
  case word {
    "'" <> rest | "\"" <> rest -> trim_quotes_start(rest)
    _ -> word
  }
}

fn trim_quotes_end(word: String) -> String {
   word 
  |> string.reverse 
  |> trim_quotes_start 
  |> string.reverse
}

pub fn count_words(input: String) -> Dict(String, Int) {
  let not_length_zero = fn(i) { string.length(i) != 0 }
  input 
  |> clean_input 
  |> string.lowercase
  |> string.split(" ")
  |> list.map(trim_quotes_start)
  |> list.map(trim_quotes_end)
  |> list.filter(not_length_zero)
  |> list.fold(dict.new(),fn(freq,word){
    dict.upsert(freq, word, fn(count){
      case count {
        Some(n) -> n + 1
        None -> 1
      }
    })
  })
}
