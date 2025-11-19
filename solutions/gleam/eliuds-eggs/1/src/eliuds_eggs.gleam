import gleam/int
import exercism/test_runner.{ debug }

pub fn egg_count(number: Int) -> Int {
  count_ones_in_string(to_binary(number))
}

fn to_binary(number: Int) -> String {
  case number == 0 {
    True -> ""
    False -> int.to_string(number % 2) <> to_binary(number/2)
  }
}
fn count_ones_in_string(string: String) -> Int {
  case string {
    "" -> 0
    "1" <> rest -> 1 + count_ones_in_string(rest)
    "0" <> rest -> 0 + count_ones_in_string(rest)
    _  -> panic as "unreachable"
  }
}