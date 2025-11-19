import gleam/list
import gleam/string
import exercism/test_runner.{ debug }

const a_codepoint_int = 65

pub fn build(letter: String) -> String {
  let top_half = build_list(letter)
  let bottom_half = top_half |> list.reverse() |> list.drop(1)
  list.append(top_half,bottom_half) |> string.join("\n")
}

pub fn build_list(letter: String) -> List(String) {
  let last_letter_index = get_last_letter_index(letter) 
  list.range(from: 0, to: last_letter_index)
  |> list.map(fn(i) { build_row(i,2 * i - 1, last_letter_index - i)})
}

fn get_last_letter_index(letter : String) -> Int {
  let assert [letter_codepoint] = string.to_utf_codepoints(letter)
  let letter_code = string.utf_codepoint_to_int(letter_codepoint)
  letter_code - a_codepoint_int
}

fn build_row (letter_index: Int, spaces_between: Int, spaces_around: Int) -> String {
  let assert Ok(letter_code) = string.utf_codepoint(a_codepoint_int + letter_index)
  let letter = string.from_utf_codepoints([letter_code])
  let space_arround = string.repeat(" ",spaces_around)
  let space_between = string.repeat(" ",spaces_between)
  case letter_index == 0 {
    True -> string.concat([space_arround, letter, space_arround])
    _ -> string.concat([space_arround, letter, space_between, letter, space_arround])
  }
  
}