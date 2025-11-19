import gleam/string

pub fn message(log_line: String) -> String {
  case log_line {
    "[ERROR]:" <> rest | "[WARNING]:" <> rest | "[INFO]:" <> rest -> string.trim(rest)
    _ -> ""
  }
}

pub fn log_level(log_line: String) -> String {
  case log_line {
    "[" <> level_line -> 
            level_line 
            |> string.reverse 
            |> string.crop("]") 
            |> string.reverse
            |> string.drop_right(1)
            |> string.lowercase
    _ -> ""
  }
}

pub fn reformat(log_line: String) -> String {
  let level = log_level(log_line)
  let msg = message(log_line)
  msg <> " (" <> level <> ")" 
}
