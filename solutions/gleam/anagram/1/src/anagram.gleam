import gleam/string
import gleam/list
import gleam/dict.{type Dict}
import exercism/test_runner.{ debug }

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let letter_dict = dict_of_letters(from: word)
  candidates |> list.filter(fn (w) { w 
      |> string.lowercase
      |> dict_of_letters 
      |> fn(x) { letter_dict == x && string.lowercase(w) != string.lowercase(word) }})
      
}

fn dict_of_letters(from word: String) -> Dict(String, Int) {
  let letters = word |> string.lowercase |> string.to_graphemes
  letters |> list.unique |> list.map(fn(x){ #(x, list.count(letters, fn(y) {x == y }))}) |> dict.from_list
}