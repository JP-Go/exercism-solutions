import gleam/result

pub fn with_retry(experiment: fn() -> Result(t, e)) -> Result(t, e) {
  case experiment() {
    Error(_) -> experiment()
    Ok(val) -> Ok(val)
  }
}

pub fn record_timing(
  time_logger: fn() -> Nil,
  experiment: fn() -> Result(t, e),
) -> Result(t, e) {
  time_logger()
  let out = experiment()
  time_logger()
  out
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
