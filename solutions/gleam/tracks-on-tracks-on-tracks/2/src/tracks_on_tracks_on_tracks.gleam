import gleam/list

pub fn new_list() -> List(String) {
  []
}

pub fn existing_list() -> List(String) {
  ["Gleam","Go","TypeScript"]
}

pub fn add_language(languages: List(String), language: String) -> List(String) {
  [language,..languages]
}

pub fn count_languages(languages: List(String)) -> Int {
  case languages {
    [] -> 0
    [_] -> 1
    [_,..rest] -> 1 + count_languages(rest)
  }
}

pub fn reverse_list(languages: List(String)) -> List(String) {
   do_reverse(languages,[])
}

fn do_reverse(alist: List(String),acc: List(String)) -> List(String) {
  case alist {
    [] -> acc
    [i, ..rest] -> do_reverse(rest, [i, ..acc])
  }
}

pub fn exciting_list(languages: List(String)) -> Bool {
  case languages {
      ["Gleam",..] | [_,"Gleam"] | [_,"Gleam",_] -> True
      _ -> False
  }
}
