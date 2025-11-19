import gleam/bool

pub fn egg_count(number: Int) -> Int {
  use <- bool.guard(when: number == 0, return: 0)
  number % 2 + egg_count(number / 2)
}