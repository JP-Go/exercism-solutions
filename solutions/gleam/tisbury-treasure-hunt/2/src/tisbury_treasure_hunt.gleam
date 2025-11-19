import gleam/list

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  #(place_location.1, place_location.0) 
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  place_location_to_treasure_location(place_location) == treasure_location
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  let #(_, place_location) = place
  let location = place_location_to_treasure_location(place_location)
  treasures |> list.fold(0, fn (count, treasure) {
    case treasure.1 == location {
      True -> count + 1
      _  -> count
    }
  })
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  case found_treasure.0, place.0, desired_treasure.0 {
    "Brass Spyglass", "Abandoned Lighthouse", _ -> True
    "Amethyst Octopus", "Stormy Breakwater", desired if desired == "Crystal Crab" || desired == "Glass Starfish" -> True
    "Vintage Pirate Hat", "Harbor Managers Office", desired if desired == "Antique Glass Fishnet Float" || desired == "Model Ship in Large Bottle"  -> True
    _,_,_ -> False
  }
}
