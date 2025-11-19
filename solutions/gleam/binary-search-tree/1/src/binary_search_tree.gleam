import gleam/list
import gleam/int

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn to_tree(data: List(Int)) -> Tree {
  case data {
    [] -> Nil
    [a,..rest] -> {
       Node(
          data: a,
          left: to_tree(rest |> list.filter(keeping: fn(x) { x <= a })),
          right: to_tree(rest |> list.filter(keeping: fn(x) { x > a })),
      )
    }
  }
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  list.sort(data,int.compare)
}

