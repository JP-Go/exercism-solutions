import gleam/list
import gleam/string
import gleam/result
import exercism/test_runner.{ debug }

pub fn is_isogram(phrase phrase: String) -> Bool {
  let letters = phrase |> string.lowercase |> string.to_graphemes |> list.filter(is_ascii_letter)
  list.unique(letters) |> list.length == letters |> list.length
}

pub fn is_ascii_letter(letter letter: String) -> Bool {
  let is_single_char = string.length(letter) == 1
  case is_single_char {
    True -> {
      let codepoints = letter |> string.to_utf_codepoints 
      let codepoint = codepoints 
                      |> list.first 
                      |> result.map(string.utf_codepoint_to_int)
                      |> result.map(fn(decimal) { decimal >= 65 && decimal <= 90 || decimal >= 97 && decimal <= 122 })
                      |> result.unwrap(False)
    }
    _ -> False 
  }
  
}