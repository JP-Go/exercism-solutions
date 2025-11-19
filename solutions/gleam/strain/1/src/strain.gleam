// Public API

pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  keep_tail(list,predicate,[])
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  keep(list, fn(x) { !predicate(x) })
}

// Private implementations

fn keep_tail(list: List(t), predicate: fn(t) -> Bool, kept: List(t)) -> List(t) {
  case list {
    [] -> reverse(kept)
    [a,..rest] -> {
      case predicate(a) {
        True -> keep_tail(rest,predicate,[a, ..kept])
        _    -> keep_tail(rest,predicate,kept)
      }
    }
  }
}

fn reverse_and_prepend(list: List(t), reversed: List(t)) -> List(t) {
  case list {
    [] -> reversed
    [a, ..rest] -> reverse_and_prepend(rest, [a,..reversed])
  }
}

fn reverse(list: List(t)) -> List(t) {
  reverse_and_prepend(list,[])
}