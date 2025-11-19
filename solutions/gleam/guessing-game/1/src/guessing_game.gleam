import gleam/int

pub fn reply(guess: Int) -> String {
  case guess {
    42 -> "Correct"
    x if x == 41 || x == 43 -> "So close"
    x if x < 42 -> "Too low"
    _ -> "Too high"
  }
}
