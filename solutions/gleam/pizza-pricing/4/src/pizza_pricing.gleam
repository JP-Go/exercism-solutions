pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  calculate_pizza_price(pizza, 0)
}

fn calculate_pizza_price(pizza: Pizza, running_total: Int) -> Int {
  case pizza {
    Margherita -> 7 + running_total
    Caprese -> 9 + running_total
    Formaggio -> 10 + running_total
    ExtraSauce(p) -> calculate_pizza_price(p, running_total + 1)
    ExtraToppings(p) -> calculate_pizza_price(p, running_total + 2)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  calculate_order_price(order, 0, 0)
}

fn calculate_order_price(
  order: List(Pizza),
  running_total: Int,
  total_pizzas: Int,
) -> Int {
  case order {
    [] ->
      running_total
      + case total_pizzas {
        1 -> 3
        2 -> 2
        _ -> 0
      }
    [pizza, ..rest] ->
      calculate_order_price(
        rest,
        running_total + pizza_price(pizza),
        total_pizzas + 1,
      )
  }
}