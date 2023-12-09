diffs = lambda { |vals, &block|
    delta = vals.each_cons(2).map { |(a, b)| b - a }
    block.(vals, delta.sum.zero? ? 0 : diffs.(delta, &block))
}
sensors = $<.map { _1.split.map(&:to_i) }

puts "Part 1: #{sensors.map { |v| diffs.(v) { |vs, d| vs.last + d } }.sum}"
puts "Part 2: #{sensors.map { |v| diffs.(v) { |vs, d| vs.first - d } }.sum}"
