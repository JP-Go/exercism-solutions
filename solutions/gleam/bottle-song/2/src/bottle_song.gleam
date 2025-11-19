import gleam/string
import gleam/list

pub fn number_to_name(num: Int) -> String {
  case num {
    10 -> "ten"
    9 -> "nine"
    8 -> "eight"
    7 -> "seven"
    6 -> "six"
    5 -> "five"
    4 -> "four"
    3 -> "three"
    2 -> "two"
    1 -> "one"
    0 -> "no"
    _ -> ""
  }
}

fn verse_one(num: Int) -> String {
  case num > 1 || num == 0{
    True -> string.capitalise(number_to_name(num)) <> " green bottles hanging on the wall,\n"
    False -> string.capitalise(number_to_name(num)) <> " green bottle hanging on the wall,\n"
  }
}

fn verse_four(num: Int) -> String {
  case num > 1 || num == 0 {
    True -> "There'll be "<> number_to_name(num)<>" green bottles hanging on the wall."
    False -> "There'll be "<> number_to_name(num)<>" green bottle hanging on the wall."
  }
}

pub fn recite(
  start_bottles start_bottles: Int,
  take_down take_down: Int,
) -> String {
  list.range(start_bottles,start_bottles - take_down + 1) |> list.map(fn(x) {
    let on_wall_verse = verse_one(x)
    let fall_verse  = "And if one green bottle should accidentally fall,\n"
    let final_verse = verse_four(x - 1)
    let complete = on_wall_verse <> on_wall_verse <> fall_verse <>final_verse
    complete
  }) |> string.join("\n\n")
}

