import gleam/string
import gleam/list
import gleam/int
import gleam/option.{Some, None, type Option}
import gleam/dict.{type Dict}
import exercism/test_runner.{debug}

pub type MatchResult {
  Win
  Loss
  Draw
}

pub type Tally = Dict(String,TeamResults)

pub type TeamResults {
  TeamResults(wins: Int, draws: Int, losses: Int)
}

pub type Match {
  Match(home_team: String, away_team: String, result: MatchResult)
}

fn get_team_points(team_results: TeamResults) -> Int {
  team_results.wins * 3 + team_results.draws
}

fn get_team_matches_played(team_results: TeamResults) -> Int {
  team_results.wins + team_results.draws + team_results.losses
}

fn parse_match_result(res : String) -> Option(MatchResult) {
  case res {
    "win" -> Some(Win)
    "draw" -> Some(Draw)
    "loss" -> Some(Loss)
    _ -> None
  }
}

fn parse_match(match: String) -> Option(Match) {
  case string.split(match,";") {
    [home_team, away_team, result] -> {
      let res = parse_match_result(result)
      case res {
        None -> None
        Some(r) -> Some(Match(home_team: home_team,away_team: away_team, result: r))
      }
    }
    _ -> None
  }
}
fn update_result_after_match(team_result: TeamResults, match: Match) -> TeamResults {
  case match.result {
    Win -> TeamResults(..team_result, wins: team_result.wins + 1)
    Loss -> TeamResults(..team_result,losses: team_result.losses + 1)
    Draw -> TeamResults(..team_result, draws: team_result.draws + 1)
  }
}

pub fn new_team_result(result: Option(TeamResults)) -> TeamResults {
  case result {
    None -> TeamResults(wins: 0, losses: 0,draws: 0)
    Some(r) -> r
  }
}

pub fn match_result_from_away_team(match: Match) -> Match {
  Match(home_team: match.away_team,away_team:match.home_team, result: case match.result {
    Win  -> Loss
    Loss -> Win
    _    -> Draw
  })
}

fn update_tally(tally: Tally, match: Option(Match)) -> Tally {
  case match {
    Some(m) -> {
      tally 
      |> dict.upsert(m.home_team,fn(result) {
        update_result_after_match(new_team_result(result),m)
      })
      |> dict.upsert(m.away_team,fn(result) {
        update_result_after_match(new_team_result(result),match_result_from_away_team(m))
      })
    }
    None -> tally
  }
  
}

fn build_tally(matches: List(Option(Match))) -> Tally {
  matches |> list.fold(dict.new(),update_tally)
}

fn build_tally_line(team_name: String, result: TeamResults) -> String {
   string.concat([
      string.pad_end(team_name, 30," "),
      " | " <> get_team_matches_played(result) |> int.to_string |> string.pad_start(2," "),
      " | " <> result.wins |> int.to_string |> string.pad_start(2," "),
      " | " <> result.draws |> int.to_string |> string.pad_start(2," "),
      " | " <> result.losses |> int.to_string |> string.pad_start(2," "),
      " | " <> get_team_points(result) |> int.to_string|> string.pad_start(2," "),
      ])
}

fn display_tally(tally: Tally) -> String {
  ["Team                           | MP |  W |  D |  L |  P" 
  ..dict.to_list(tally) 
  |> list.sort(fn(team_a,team_b) {
    string.compare(team_a.0,team_b.0)
  })
  |> list.sort(fn(team_a,team_b) {
    int.compare(-get_team_points(team_a.1),-get_team_points(team_b.1))
  })
  |> list.map(fn(entry) {
      let #(team_name, result) = entry
      build_tally_line(team_name, result)
  })
  ] 
  |> string.join("\n")
}

pub fn tally(input: String) -> String {
  input 
  |> string.split("\n") 
  |> list.map(parse_match)
  |> build_tally
  |> display_tally
}
