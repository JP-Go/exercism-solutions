// with list functions

import gleam/list
import gleam/result
import gleam/int

pub fn today(days: List(Int)) -> Int {
  list.first(days) |> result.unwrap(0)
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  [today(days) + 1,..list.drop(days,1) ]
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  list.any(days, fn(x){x == 0})
}

pub fn total(days: List(Int)) -> Int {
  int.sum(days)
}

pub fn busy_days(days: List(Int)) -> Int {
  list.count(days, fn(x) { x >=5 })
}
