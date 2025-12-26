import gleam/bool

pub type Error {
  NonPositiveNumber
}

pub fn steps(number: Int) -> Result(Int, Error) {
  use <- bool.guard(number <= 0, Error(NonPositiveNumber))
  Ok(step_collatz(number, 0))
}

fn step_collatz(n: Int, total: Int) {
  use <- bool.guard(n == 1, total)
  step_collatz(case n % 2 == 0 { True -> n /2 _ -> 3 * n + 1 }, total + 1)
}