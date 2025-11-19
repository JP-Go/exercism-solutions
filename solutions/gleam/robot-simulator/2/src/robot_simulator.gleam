import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

type Instruction {
  Face(Direction)
  Advance
}

type TurnDirection {
  Left
  Right
}

pub type Position {
  Position(x: Int, y: Int)
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction, position)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  create(direction, position)
  |> execute_instructions(
    parse_instructions(direction, instructions |> string.to_graphemes, []),
  )
}

fn execute_instructions(robot: Robot, instructions: List(Instruction)) -> Robot {
  case instructions {
    [] -> robot
    [Face(direction), ..rest] ->
      execute_instructions(Robot(..robot, direction: direction), rest)
    [Advance, ..rest] -> execute_instructions(advance_robot(robot), rest)
  }
}

fn advance_robot(robot: Robot) -> Robot {
  let position = robot.position
  case robot.direction {
    North -> Robot(..robot, position: Position(..position, y: position.y + 1))
    East -> Robot(..robot, position: Position(..position, x: position.x + 1))
    West -> Robot(..robot, position: Position(..position, x: position.x - 1))
    South -> Robot(..robot, position: Position(..position, y: position.y - 1))
  }
}

fn parse_instructions(
  facing: Direction,
  raw_instructions: List(String),
  instructions: List(Instruction),
) -> List(Instruction) {
  case raw_instructions {
    [] -> list.reverse(instructions)
    [i, ..rest] if i == "R" || i == "L" -> {
      parse_instructions(rotate(facing, to_turn(i)), rest, [
        Face(rotate(facing, to_turn(i))),
        ..instructions
      ])
    }
    [i, ..rest] if i == "A" ->
      parse_instructions(facing, rest, [Advance, ..instructions])
    [_, ..rest] -> parse_instructions(facing, rest, instructions)
  }
}

fn to_turn(raw_turn: String) -> Option(TurnDirection) {
  case raw_turn {
    "R" -> Some(Right)
    "L" -> Some(Left)
    _ -> None
  }
}

fn rotate(
  initial_direction: Direction,
  turn: Option(TurnDirection),
) -> Direction {
  case initial_direction, turn {
    _, None -> initial_direction
    North, Some(Left) -> West
    East, Some(Left) -> North
    South, Some(Left) -> East
    West, Some(Left) -> South
    North, Some(Right) -> East
    East, Some(Right) -> South
    South, Some(Right) -> West
    West, Some(Right) -> North
  }
}
