pub fn equilateral(a: Float, b: Float, c: Float) -> Bool {
  a == b && b == c && a != 0.0 && b != 0.0 && c != 0.0
}

pub fn isosceles(a: Float, b: Float, c: Float) -> Bool {
  {a == b  || b == c || c == a} && inequality(a,b,c)
}

pub fn scalene(a: Float, b: Float, c: Float) -> Bool {
  {a != b && b != c && a != c} && inequality(a,b,c)
}

pub fn inequality(a: Float, b: Float, c: Float) -> Bool {
  a +. b >=. c && b +. c >=. a && a +. c >=. b
}