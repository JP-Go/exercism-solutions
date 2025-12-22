import gleam/option.{type Option,Some,None}
import gleam/list
import gleam/string

pub type Student {
  Alice
  Bob
  Charlie
  David
  Eve
  Fred
  Ginny
  Harriet
  Ileana
  Joseph
  Kincaid
  Larry
}

pub type Plant {
  Radishes
  Clover
  Violets
  Grass
}

pub fn plants(diagram: String, student: Student) -> List(Plant) {
  let initial_column = student_initial_column(student)
  let parse_student_row = fn(row) { 
    string.slice(row,initial_column,2) 
    |> string.to_graphemes 
    |> list.map(plant_string_to_plant)
    |> option.values 
  }
  diagram 
  |> string.split("\n") 
  |> list.flat_map(parse_student_row)
}
fn plant_string_to_plant(string: String) -> Option(Plant) {
  case string {
    "R" -> Some(Radishes)
    "V" -> Some(Violets)
    "C" -> Some(Clover)
    "G" -> Some(Grass)
    _ -> None
  }
}

fn student_initial_column(student: Student) -> Int{
  case student {
    Alice -> 0
    Bob -> 2
    Charlie -> 4
    David -> 6
    Eve -> 8
    Fred -> 10
    Ginny -> 12
    Harriet -> 14
    Ileana -> 16
    Joseph -> 18
    Kincaid -> 20
    Larry -> 22
  }
}