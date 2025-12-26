import gleam/int
import gleam/list
import gleam/result

pub fn is_armstrong_number(number: Int) -> Bool {
  let digits = int.digits(number,10) |> result.unwrap([])
  let digit_count = list.length(digits)
  digits |> list.map(int_pow(_,digit_count)) |> int.sum == number
}

fn int_pow(number: Int, to power: Int) -> Int {
  list.fold(list.repeat(number,power),1,int.multiply)
}