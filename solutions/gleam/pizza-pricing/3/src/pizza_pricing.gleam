import gleam/list

pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
} 

pub fn pizza_price(pizza: Pizza) -> Int {
  calculate_pizza_price(pizza,0)
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
  calculate_order_price(order) + extra_for_order_size(list.length(order))
}

fn extra_for_order_size(order_size: Int) -> Int {
  case order_size { 1 -> 3 2 -> 2 _ -> 0}
}

fn calculate_order_price(order: List(Pizza)) -> Int {
    use total, pizza <- list.fold(order,0) 
    total + pizza_price(pizza)
}
