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
  use row <-list.flat_map(string.split(diagram,"\n")) 
  string.slice(row,student_index(student),2) 
  |> string.to_graphemes 
  |> list.map(to_plant)
  |> option.values
}
fn to_plant(string: String) -> Option(Plant) {
  case string {
    "R" -> Some(Radishes)
    "V" -> Some(Violets)
    "C" -> Some(Clover)
    "G" -> Some(Grass)
    _ -> None
  }
}

fn student_index(student: Student) -> Int{
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