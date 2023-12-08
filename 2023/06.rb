# alternative: brute force
_solve = lambda { |(t, d)|
    b = (t / 2..).take_while { _1 * (t - _1) > d }.size
    t.even? ? 2 * b - 1 : 2 * b - 2
}
# alternative: binary search
_solve = lambda { |(t, d)|
    b1 = (0...t / 2).bsearch { _1 * (t - _1) > d }
    b2 = (t / 2...t).bsearch { _1 * (t - _1) < d }
    b2 - b1
}
# alternative: fixup binary search
solve = lambda { |(t, d)|
    b = t / 2 - (0...t / 2).bsearch { _1 * (t - _1) > d }
    2 * b + 1 + t % 2
}
# alternative: maths
_solve = lambda { |(t, d)|
    b1 = (t + (t * t - 4 * d)**0.5) / 2
    b2 = (t - (t * t - 4 * d)**0.5) / 2
    b1.ceil - b2.floor - 1
}
# alternative: fixup maths
_solve = lambda { |(t, d)|
    b = ((t * t - 4 * d - 4)**0.5).to_i
    b + (t + b + 1) % 2
}

s = $<.map { _1.split[1..].map(&:to_i) }
puts "Part 1: #{s.reduce(&:zip).map(&solve).reduce :*}"
puts "Part 2: #{solve.(s.map(&:join).map(&:to_i))}"
