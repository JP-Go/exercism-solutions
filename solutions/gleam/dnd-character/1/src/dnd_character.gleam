import gleam/int
import gleam/result.{unwrap}
import gleam/list

pub type Character {
  Character(
    charisma: Int,
    constitution: Int,
    dexterity: Int,
    hitpoints: Int,
    intelligence: Int,
    strength: Int,
    wisdom: Int,
  )
}

pub fn generate_character() -> Character {
  let constitution = ability() 
  Character(
      charisma: ability(),
      constitution: constitution ,
      strength: ability(),
      dexterity: ability(),
      intelligence: ability(),
      hitpoints: modifier(constitution) + 10,
      wisdom: ability()
    )
}

pub fn modifier(score: Int) -> Int {
  unwrap(int.floor_divide(score - 10 , 2),0)
}

pub fn ability() -> Int {
  int.sum([int.random(6) + 1,int.random(6) + 1,int.random(6) + 1])
}
