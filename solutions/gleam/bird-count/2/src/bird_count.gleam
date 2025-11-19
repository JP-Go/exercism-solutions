// simple recursions

pub fn today(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [i, ..] -> i
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [i,..rest] -> [i +1,..rest]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  case days {
    [] -> False
    [0, ..] -> True
    [_,..rest] -> has_day_without_birds(rest)
  }
}

pub fn total(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [i,..rest] -> i + total(rest)
  }
}

pub fn busy_days(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [i,..rest] -> case i >= 5 { True -> 1 _ -> 0 } + busy_days(rest)
  }
}
