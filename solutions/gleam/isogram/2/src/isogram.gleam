import gleam/list
import gleam/string

pub fn is_isogram(phrase phrase: String) -> Bool {
  let remove_char = fn(chars,char) { chars |> string.replace(each: char, with: "") }
  let all_items_uniq = fn (alist) { list.unique(alist) == alist }
  let letters = phrase 
      |> string.lowercase 
      |> remove_char("-")
      |> remove_char(" ")
      |> string.to_graphemes
      |> all_items_uniq
}