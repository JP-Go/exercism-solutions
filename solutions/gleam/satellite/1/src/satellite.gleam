import gleam/list
import gleam/bool
import gleam/result
import exercism/test_runner.{ debug }

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
  use <- bool.guard(when: list.unique(inorder) != inorder,return: Error(NonUniqueItems))
  use <- bool.guard(when: list.unique(preorder) != preorder,return:  Error(NonUniqueItems))
  traverse(inorder,preorder)
}

fn traverse(
  inorder inorder: List(a),
  preorder preorder: List(a),
) -> Result(Tree(a), Error) {
  let root = list.first(preorder)
  case root {
    Ok(value) -> {
      case list.contains(inorder, value) {
        True -> {
          let #(left_subtree,right_subtree) = list.split_while(inorder, fn(x) { value != x })
          let assert [_,..rest] = preorder
          debug("inside")
          debug(left_subtree)
          debug(right_subtree |> list.drop(1))
          debug("end")
          Ok(Node(value: value, 
              left: traverse(left_subtree,list.filter(rest, fn(x){ list.contains(left_subtree,x) })) |> result.unwrap(Nil), 
              right: traverse(right_subtree |> list.drop(1),list.filter(rest, fn(x){ list.contains(right_subtree,x) })) |> result.unwrap(Nil))
          )
        }
        _ -> Error(DifferentItems)
      }
    }
    Error(_) -> Ok(Nil)
  }
}
