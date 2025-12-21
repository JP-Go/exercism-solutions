import gleam/result
import gleam/list
import gleam/int
import gleam/float

pub type Resistance {
  Resistance(unit: String, value: Int)
}

fn parse_color(color: String) -> Result(Int,String) {
  case color {
    "black"-> Ok(0)
    "brown"-> Ok(1)
    "red"-> Ok(2)
    "orange"-> Ok(3)
    "yellow"-> Ok(4)
    "green"-> Ok(5)
    "blue"-> Ok(6)
    "violet"-> Ok(7)
    "grey"-> Ok(8)
    "white"-> Ok(9)
    _ -> Error("Invalid color")
  }
}

fn compute_resistance(resistance_code: List(Int)) -> Result(Resistance, Nil) {
  let assert [a,b,c,..] = resistance_code
  let value = { a * 10 + b } * { int.power(10, int.to_float(c)) |> result.unwrap(0.0) |> float.truncate }
  case value {
    i if i >= 1_000_000_000 -> Ok(Resistance(value: value /1_000_000_000 ,unit: "gigaohms"))
    i if i >= 1_000_000 -> Ok(Resistance(value: value /1_000_000 ,unit: "megaohms"))
    i if i >= 1000 -> Ok(Resistance(value: value /1000 ,unit: "kiloohms"))
    i if i < 1000 -> Ok(Resistance(value:, unit: "ohms"))
    _ -> Error(Nil)
  }
}

pub fn label(colors: List(String)) -> Result(Resistance, Nil) {
  list.map(colors, parse_color)
  |> result.all
  |> result.map(compute_resistance)
  |> result.replace_error(Nil)
  |> result.flatten
}
