import gleam/list
import gleam/int

pub fn sum(factors factors: List(Int), limit limit: Int) -> Int {
  factors 
  |> list.map(fn (x) { multiples(of: x, up_to: limit, from: x, result: []) })  
  |> list.flatten
  |> list.unique
  |> int.sum
}

fn multiples(of base: Int, up_to limit: Int, from from: Int, result result: List(Int)) -> List(Int) {
  let base_greater_than_limit = base > limit 
  case limit % base {
    _ if base_greater_than_limit -> []
    0 -> list.range(1, limit / base - 1) |> list.map(int.multiply(_,base))
    _ -> list.range(1, limit / base ) |> list.map(int.multiply(_,base)) 
  }
}