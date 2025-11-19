import gleam/order.{type Order}
import gleam/float
import gleam/list

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  {f -. 32.0} /. 1.8
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  case left, right {
    Fahrenheit(t1), Fahrenheit(t2) | Celsius(t1), Celsius(t2) -> float.compare(t1,t2)
    Celsius(t1), Fahrenheit(t2) -> float.compare(t1,fahrenheit_to_celsius(t2))
    Fahrenheit(t1), Celsius(t2) -> float.compare(fahrenheit_to_celsius(t1),t2)
  }
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  list.sort(cities,fn(c1,c2) {compare_temperature(c1.temperature,c2.temperature)} )
}
