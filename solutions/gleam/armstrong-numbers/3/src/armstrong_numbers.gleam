import gleam/int
import gleam/list

pub fn is_armstrong_number(number: Int) -> Bool {
  let assert Ok(digits) = int.digits(number,10)
  let digit_count = list.length(digits)
  digits |> list.map(int_pow(_,digit_count)) |> int.sum == number
}

pub fn int_pow(number: Int, to power: Int) -> Int {
  do_int_pow(number,to: power,result: 1)
}

fn do_int_pow(number: Int, to power: Int, result acc: Int) -> Int {
  case power {
    0 -> 1
    1 -> number * acc
    n if n > 1 -> do_int_pow(number,n - 1, acc * number)
    _ -> panic as "Invalid input for int_pow"
  }
}