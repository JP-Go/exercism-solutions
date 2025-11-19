pub type TreasureChest(treasure) {
  TreasureChest(password: String, treasure: treasure)
}

pub type UnlockResult(a) {
  Unlocked(a)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case chest.password == password {
    True -> Unlocked(chest.treasure)
    _ -> WrongPassword 
  }
}
