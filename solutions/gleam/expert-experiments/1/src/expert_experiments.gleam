import gleam/result

pub fn with_retry(experiment: fn() -> Result(t, e)) -> Result(t, e) {
  let outcome = experiment()
  case outcome {
    Error(_) -> experiment()
    Ok(_) -> outcome
  }
}

pub fn record_timing(
  time_logger: fn() -> Nil,
  experiment: fn() -> Result(t, e),
) -> Result(t, e) {
  time_logger()
  let outcome = experiment()
  time_logger()
  outcome
}

pub fn run_experiment(
  name: String,
  setup: fn() -> Result(t, e),
  action: fn(t) -> Result(u, e),
  record: fn(t, u) -> Result(v, e),
) -> Result(#(String, v), e) {
  use setup_res <- result.try(setup())
  use action_res <- result.try(action(setup_res))
  use final_record <- result.try(record(setup_res,action_res))
  Ok(#(name, final_record))
}
