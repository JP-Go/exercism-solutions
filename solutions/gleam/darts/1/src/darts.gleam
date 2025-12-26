pub fn score(x: Float, y: Float) -> Int {
  case x *. x +. y *. y {
    n if n <=. 1. -> 10
    n if n <=. 25. -> 5
    n if n <=. 100. -> 1
    _ -> 0
  }
}
