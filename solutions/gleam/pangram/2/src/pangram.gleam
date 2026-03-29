import gleam/string
import gleam/set

pub fn is_pangram(sentence: String) -> Bool {
  let alphabet = set.from_list(string.split("abcdefghijklmnopqrstuvwxyz",""))
  let sentence_char_set = string.lowercase(sentence) 
    |> string.split("")
    |> set.from_list
  set.is_subset(alphabet,sentence_char_set)
}
