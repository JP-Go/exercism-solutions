// LIST OPERATIONS SOLUTION
import gleam/list
pub fn accumulate(lst: List(a), fun: fn(a) -> b) -> List(b) {
  list.map(lst, fun)
}
