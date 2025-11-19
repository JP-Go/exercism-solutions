import gleam/string

pub fn message(log_line: String) -> String {
  case log_line {
    "[ERROR]:" <> rest | "[WARNING]:" <> rest | "[INFO]:" <> rest -> rest
    _ -> log_line
  } 
  |> string.trim
}

pub fn log_level(log_line: String) -> String {
  case log_line {
    "[WARNING]:"<> _ -> "warning"
    "[ERROR]:" <> _ -> "error"
    "[INFO]:" <> _ -> "info"
    _ -> log_line
  }
}

pub fn reformat(log_line: String) -> String {
  let level = log_level(log_line)
  let msg = message(log_line)
  msg <> " (" <> level <> ")" 
}
