import gleam/option.{type Option, Some, None}
import gleam/int

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  option.unwrap(player.name, "Mighty Magician")
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health {
    0 if player.level >= 10 -> player |> update_health(100) |> update_mana(Some(100)) |> Some
    0 -> player |> update_health(100) |> Some
    _ -> None
  }
}

fn update_health(player: Player, new_value: Int) -> Player {
  Player(..player, health: int.max(new_value, 0))
}
fn update_mana(player: Player, new_value: Option(Int)) -> Player {
  Player(..player, mana: new_value)
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    None -> #(player |> update_health(player.health - cost), 0)
    Some(mana) if mana >= cost -> #(player |> update_mana(Some(mana-cost)), cost * 2)
    Some(_) -> #(player, 0)
  }
}
