import gleam/list

pub type Triplet {
  Triplet(Int, Int, Int)
}

pub fn triplets_with_sum(sum: Int) -> List(Triplet) {
    // ranging a to a third of sum because a is a term of a + b + c
    use a <- list.flat_map(list.range(1, sum/3))      
    // ranging b to half of sum because b is a term of a + b + c and max(a) = sum/3 
    // so max(a) <= max(b) <= max(c) => s/3 <= max(b) <= s
    use b <- list.filter_map(list.range(a, sum/2)) 
    let c = sum - { a + b }
    case c * c == a * a + b * b  {
        True -> Ok(Triplet(a,b,c))
        _ -> Error(Nil)
    }
}
