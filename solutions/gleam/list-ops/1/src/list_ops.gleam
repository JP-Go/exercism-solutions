pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  foldl(second,reverse(first), fn(acc,x){ [x,..acc] }) |> reverse
}

pub fn concat(lists: List(List(a))) -> List(a) {
  foldl(lists,[],fn(acc,x) { append(acc,x) })
}

pub fn filter(list: List(a), function: fn(a) -> Bool) -> List(a) {
  let append_if = fn(acc,x) { append(case function(x) { True -> [x] _ -> []},acc)}
  foldl(list,[],append_if) |> reverse
}

pub fn length(list: List(a)) -> Int {
  foldl(list,0,fn(count,_) { count + 1 })
}

pub fn map(list: List(a), function: fn(a) -> b) -> List(b) {
  foldl(list,[], fn(acc,x){ append(acc,[function(x)])})
}

pub fn foldl(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [x,..rest] -> foldl(rest,function(initial,x),function)
  }
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [x,..rest] -> function(foldr(rest,initial,function), x)
  }
}

pub fn reverse(list: List(a)) -> List(a) {
  foldl(list,[], fn(acc,x) { [x,..acc] })
}