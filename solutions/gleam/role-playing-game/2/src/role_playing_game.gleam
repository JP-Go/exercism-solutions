import gleam/option.{type Option,Some,None}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  option.unwrap(player.name, "Mighty Magician")
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health {
    0 if player.level >= 10 -> Some(player |> update_health(100) |> update_mana(Some(100)) )
    0 -> Some(player |> update_health(100))
    _ -> None
  }
}

fn update_health(player: Player, new_value: Int) -> Player {
  case new_value{
    0 -> Player(..player, health: 0)
    val if val < 0 -> Player(..player, health: 0)
    _ -> Player(..player, health: new_value)
  }
}
fn update_mana(player: Player, new_value: Option(Int)) -> Player {
  case new_value {
    Some(_) -> Player(..player, mana: new_value)
    None -> Player(..player, mana: None)
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    Some(mana) if mana >= cost -> #(player |> update_mana(Some(mana-cost)), cost * 2)
    Some(_) -> #(player, 0)
    None -> #(update_health(player, player.health - cost),0)
  }
}
