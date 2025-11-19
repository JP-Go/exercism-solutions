import gleam/int
import gleam/list
import gleam/string

type Drops = Int
type Rainsound {
  Raindrops(String)
  NoSound
}
pub fn convert(number: Int) -> String {
  let sounds = [#(3, Raindrops("Pling")), #(5,Raindrops("Plang")), #(7, Raindrops("Plong"))]
  create_sound_mapper(with_sounds: sounds)(number)
  |> list.map(rainsound_to_string)
  |> string.join(with: "")
  |> fn (str) {
      case str {
        "" -> int.to_string(number)
        _ -> str
      }
  }
}

fn create_sound_mapper(with_sounds sounds: List(#(Drops, Rainsound))) -> fn (Int) -> List(Rainsound) {
  fn (n) {
    sounds 
    |> list.map(with: map_number_to_sound(_, n))
  }
}

fn map_number_to_sound(sound_divisor: #(Drops, Rainsound),number: Int) -> Rainsound {
  case number % sound_divisor.0 {
    0 -> sound_divisor.1
    _ -> NoSound
  }
} 

fn rainsound_to_string(sound: Rainsound) -> String {
  case sound {
    Raindrops(s) -> s
    _ -> ""
  }
}