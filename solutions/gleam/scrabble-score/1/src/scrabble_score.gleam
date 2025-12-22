import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn score(word: String) -> Int {
    let points_map = dict.from_list([
    #(["a","e","i","o","u","l","n","r","s","t"], 1 ),
    #(["d","g"], 2 ),
    #(["b","c","m","p"], 3 ),
    #(["f","h","v","w","y"], 4 ),
    #(["k"], 5 ),
    #(["j","x"], 8 ),
    #(["q","z"], 10 )
  ])
  compute_score(word,points_map,0)
}

fn compute_score(word: String, point_map: Dict(List(String),Int), total: Int) -> Int {
  case string.pop_grapheme(word) {
    Error(_) -> total
    Ok(#(l,rest)) -> {
      let assert [points] =  point_map 
      |> dict.filter(fn(key,_){ list.contains(key, string.lowercase(l))}) 
      |> dict.values
      compute_score(rest,point_map,total + points)
    } 
  }
}
