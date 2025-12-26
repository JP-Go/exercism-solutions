let score (x: float) (y: float): int =
  match x *. x +. y *. y with 
    | n when n <= 1.0 -> 10
    | n when n <= 25.0 -> 5
    | n when n <= 100.0 -> 1
    | otherwise -> 0  
