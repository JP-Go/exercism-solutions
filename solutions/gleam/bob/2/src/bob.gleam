import gleam/string
import gleam/list
import gleam/result

pub fn hey(remark: String) -> String {
  let remark = string.trim(remark)
  let is_yelling = string.uppercase(remark) == remark && string.lowercase(remark) != remark
  let is_question = string.ends_with(remark, "?")
  case remark {
      "" -> "Fine. Be that way!"
      _ if is_yelling && is_question -> "Calm down, I know what I'm doing!"
      _ if is_yelling -> "Whoa, chill out!" 
      _ if is_question -> "Sure."
      _  ->  "Whatever."
      
  }
}