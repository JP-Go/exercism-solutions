import gleam/list
import gleam/bool
import gleam/result

pub type Tree(a) {
  Nil
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub type Error {
  DifferentLengths
  DifferentItems
  NonUniqueItems
}

pub fn tree_from_traversals(
  inorder inorder: List(a),
  preorder preorder: List(a),
) -> Result(Tree(a), Error) {
  use <- bool.guard(when: list.length(inorder) != list.length(preorder), return: Error(DifferentLengths))
  use <- bool.guard(when: list.unique(inorder) != inorder || list.unique(preorder) != preorder,return: Error(NonUniqueItems))
  traverse(inorder,preorder)
}

fn traverse(
  inorder inorder: List(a),
  preorder preorder: List(a),
) -> Result(Tree(a), Error) {
  use <- bool.guard(list.is_empty(preorder),return: Ok(Nil))
  let assert [root, ..rest] = preorder
  case list.contains(inorder, root) {
    True -> {
      let #(inorder_left,inorder_right) = list.split_while(inorder, fn(x) { root != x })
      let preorder_left = list.filter(rest, fn(x){ list.contains(inorder_left,x) })
      let preorder_right = list.filter(rest, fn(x){ list.contains(inorder_right,x) })
      Ok(Node(value: root, 
          left: traverse(inorder_left,preorder_left) |> result.unwrap(Nil), 
          right: traverse(inorder_right |> list.drop(1), preorder_right) |> result.unwrap(Nil)
        ))
      }
        _ -> Error(DifferentItems)
  }
}
