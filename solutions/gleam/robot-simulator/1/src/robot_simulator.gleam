import exercism/test_runner.{ debug }
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
  Robot(direction,position)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  let robot = create(direction,position)
  let instructions = parse_instructions(direction,instructions)
  execute_instructions(robot,instructions)
}

fn execute_instructions(robot: Robot, instructions: List(Instruction)) -> Robot {
  case instructions {
    [] -> robot
    [Face(direction),..rest] -> execute_instructions(Robot(..robot, direction: direction),rest)
    [Advance,..rest] -> execute_instructions(advance_robot(robot),rest)
  }
}

fn advance_robot(robot:Robot) -> Robot {
   let position = robot.position
   case robot.direction {
      North -> Robot(..robot, position: Position(..position, y: position.y + 1))
      East -> Robot(..robot, position: Position(..position, x: position.x + 1))
      West -> Robot(..robot, position: Position(..position, x: position.x - 1))
      South -> Robot(..robot, position: Position(..position, y: position.y - 1))
   }
}

fn parse_instructions(facing: Direction, instructions: String) -> List(Instruction) {
  case instructions {
    "" -> []
    "R" <> rest -> {
      let new_direction = rotate(facing,Right)
      [Face(new_direction),..parse_instructions(new_direction,rest)]
    }
    "L" <> rest -> {
      let new_direction = rotate(facing,Left)
      [Face(new_direction),..parse_instructions(new_direction,rest)]
    }
    "A" <> rest -> [Advance,..parse_instructions(facing, rest)]
    _ -> parse_instructions(facing, string.drop_start(instructions,1))
  }
}

fn rotate(initial_direction: Direction, turn: TurnDirection) -> Direction {
  case initial_direction, turn {
    North, Left -> West
    East, Left -> North
    South, Left -> East
    West, Left -> South
    North, Right -> East
    East, Right -> South
    South, Right -> West
    West, Right -> North
  }
}