import gleam/list
import gleam/dict.{type Dict}
import gleam/int
import exercism/test_runner.{ debug }

pub type Category {
  Ones
  Twos
  Threes
  Fours
  Fives
  Sixes
  FullHouse
  FourOfAKind
  LittleStraight
  BigStraight
  Choice
  Yacht
}

type RuleFunction = fn(List(Int)) -> Int

fn rules() -> Dict(Category,RuleFunction) {
  dict.from_list([
     number_count_rule(Ones,1,sum_of_dice_point_calculation),
     number_count_rule(Twos,2,sum_of_dice_point_calculation),
     number_count_rule(Threes,3,sum_of_dice_point_calculation),
     number_count_rule(Fours,4,sum_of_dice_point_calculation),
     number_count_rule(Fives,5,sum_of_dice_point_calculation),
     number_count_rule(Sixes,6,sum_of_dice_point_calculation),
     counts_rule(FullHouse,[[3,2]],sum_of_dice_point_calculation),
     counts_rule(FourOfAKind,[[4,1],[5]],sum_of_subset_point_calculation(4)),
     counts_rule(Yacht,[[5]],fixed_value_point_calculation(50)),
     pattern_rule(LittleStraight,[1,2,3,4,5],fixed_value_point_calculation(30)),
     pattern_rule(BigStraight,[2,3,4,5,6],fixed_value_point_calculation(30)),
     rule(Choice,sum_of_dice_point_calculation),
  ])
}

fn rule(category:Category, rule_function: RuleFunction) -> #(Category,RuleFunction) {
  #(category, rule_function)
}

fn number_count_rule(
  category: Category, 
  number: Int, 
  point_calculation: fn(List(Int)) -> Int
) -> #(Category,RuleFunction) {
  rule(
    category, 
    fn (dice) {
      list.filter(dice,fn (x) { x == number }) 
      |> point_calculation
    }
   )
}

fn sum_of_dice_point_calculation(dice: List(Int)) -> Int {
  int.sum(dice)
}
fn sum_of_subset_point_calculation(subset_length: Int) -> fn(List(Int)) -> Int  {
  fn(dice: List(Int)){
    list.group(dice,fn (x) { x }) 
    |> dict.values
    |> list.filter(fn(group) { list.length(group) >= subset_length})
    |> list.flatten
    |> list.take(subset_length)
    |> int.sum
  }
}
fn fixed_value_point_calculation(value:Int) -> fn(List(Int)) -> Int {
  fn(dice: List(Int)){
    value
  }
}

fn pattern_rule(
  category: Category, 
  pattern: List(Int),
  point_calculation: fn(List(Int)) -> Int
) -> #(Category,RuleFunction) {
  rule(
    category, 
    fn (dice) {
      case dice |> list.sort(int.compare) == pattern |> list.sort(int.compare) {
        True -> point_calculation(dice)
        _ -> 0
      }
    }
   )
}
fn counts_rule(
  category: Category, 
  patterns: List(List(Int)),
  point_calculation: fn(List(Int)) -> Int
) -> #(Category,RuleFunction) {
  let sorted_counts = patterns |> list.map(fn(pat) { list.sort(pat,int.compare)})
  rule(
    category, 
    fn (dice) {
      let dice_counts = list.group(dice,fn (x) { x }) 
        |> dict.values
        |> list.map(list.length)
        |> list.sort(int.compare)
      debug(dice_counts)
      debug(sorted_counts)
      case list.contains(sorted_counts, dice_counts)  {
        True -> point_calculation(dice)
        _ -> 0
      }
    }
   )
}

pub fn score(category: Category, dice: List(Int)) -> Int {
  let assert Ok(rule) = dict.get(rules(),category)
  rule(dice)
}