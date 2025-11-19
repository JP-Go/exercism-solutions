import gleam/list 

pub fn wines_of_color(wines: List(Wine), color: Color) -> List(Wine) {
  wines |> list.filter(fn(w) { is_of_color(wine: w, of_color: color) } )  
}

pub fn wines_from_country(wines: List(Wine), country: String) -> List(Wine) {
  wines |> list.filter(fn(w) {from_country(w,country)})
}

pub fn filter(wines: List(Wine),color color: Color, country country: String) -> List(Wine) {
  wines |> wines_from_country(country) |> wines_of_color(color)
}

fn is_of_color(wine wine: Wine, of_color color: Color) {
  wine.color == color
}

fn from_country(wine wine: Wine, from_country country: String) {
  wine.country == country
}

pub type Wine {
  Wine(name: String, year: Int, country: String, color: Color)
}

pub type Color {
  Red
  Rose
  White
}
