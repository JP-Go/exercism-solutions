import gleam/set.{type Set}
import gleam/list
import gleam/string
import gleam/result
import exercism/test_runner.{debug}

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  #(set.size(set.insert(collection,card)) == set.size(collection), set.insert(collection,card))
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let is_possible_and_worth_it = set.contains(collection,my_card) && !set.contains(collection, their_card)
  let trade_result = collection |> set.insert(their_card) |> set.delete(my_card)
  #(is_possible_and_worth_it,trade_result)
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  let sort_by_name = list.sort(_,string.compare)
  collections 
  |> list.reduce(set.intersection) 
  |> result.map(set.to_list) 
  |> result.map(sort_by_name)
  |> result.unwrap([])
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  collections |> list.reduce(set.union) |> result.unwrap(set.new()) |> set.size
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  let is_shinny = string.contains(_, "Shiny ")
  set.filter(collection,is_shinny)
}
