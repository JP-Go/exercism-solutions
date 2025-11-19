import gleam/string
import gleam/list
import gleam/result

pub fn hey(remark: String) -> String {
  let remark = string.trim(remark)
  case is_yelling(remark), is_question(remark), remark {
      _ , _ , "" -> "Fine. Be that way!"
      True, True, _ -> "Calm down, I know what I'm doing!"
      True, False, _ -> "Whoa, chill out!" 
      False, True, _ -> "Sure."
      _ , _ , _  ->  "Whatever."
      
  }
}

fn is_yelling(remark: String) -> Bool {
  is_uppercase_phrase(remark)
}

fn is_question(remark: String) -> Bool {
  string.ends_with(remark, "?")
}

fn is_uppercase_phrase(str: String) -> Bool {
  let letters = string.to_graphemes(str) |> list.filter(is_alpha)
  list.length(letters) > 0 && list.all(letters,is_uppercase)
}

fn ord(str: String) -> Result(Int, String) {
  case string.length(str) {
    1 -> Ok(str |> string.to_utf_codepoints 
                |> list.map(string.utf_codepoint_to_int) 
                |> list.first
                |> result.unwrap(0))
    _ -> Error("Ord applied to a string with length greater than one")
  }
}

fn is_alpha(str: String) -> Bool {
  let assert Ok(ordinal_value) = ord(str)
  {ordinal_value >= 65 && ordinal_value <= 90 } || {ordinal_value >= 97 && ordinal_value <= 122 }
}

fn is_uppercase(str: String) -> Bool {
  let assert Ok(ordinal_value) = ord(str)
  ordinal_value >= 65 && ordinal_value <= 90
}