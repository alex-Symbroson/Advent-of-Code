s = $<.readlines.map { _1.split[1..].map(&:to_i) }
solve = lambda { |(t, d)|
    b = (t / 2..).take_while { _1 * (t - _1) > d }.size
    t.even? ? 2 * b - 1 : 2 * b - 2
}
puts "Part 1: #{s.reduce(&:zip).map(&solve).reduce(&:*)}"
puts "Part 2: #{solve.call(s.map(&:join).map(&:to_i))}"

# alternative
solve = lambda { |(t, d)|
    b1 = (t + (t * t - 4 * d)**0.5) / 2
    b2 = (t - (t * t - 4 * d)**0.5) / 2
    b1.ceil - b2.floor - 1
}
