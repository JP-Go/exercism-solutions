import gleam/list
import gleam/string

type BracketType {
  Round
  Square
  Curly
}

type Bracket {
  Open(t: BracketType)
  Close(t: BracketType)
  NotBracket
}
type BracketStack = List(Bracket)

pub fn is_paired(value: String) -> Bool {
  value 
      |> string.to_graphemes
      |> list.map(map_delimiter)
      |> list.filter(fn(x) { case x { NotBracket -> False _ -> True  } })
      |> list.fold_until([],should_continue_matching)
      |> list.is_empty()
}
fn should_continue_matching(stack: BracketStack, current_bracket: Bracket) 
  -> list.ContinueOrStop(BracketStack) {
      case stack, current_bracket {
          _ , Open(_)                              -> list.Continue([current_bracket,..stack])
          [Open(k),..new_acc], Close(t) if t == k  -> list.Continue(new_acc)
          _, _                                     -> list.Stop([current_bracket])
      }
  }


fn map_delimiter(str: String) -> Bracket {
  case str {
    "(" -> Open(Round)
    "[" -> Open(Square)
    "{" -> Open(Curly)
    ")" -> Close(Round)
    "]" -> Close(Square)
    "}" -> Close(Curly)
    _ -> NotBracket
  }
}