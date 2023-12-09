diffs = lambda { |vals|
    p delta = vals.each_cons(2).map { _2 - _1 }
    vals.last + (delta.uniq.size == 1 ? 0 : diffs.(delta))
}
sensors = $<.map { _1.split.map(&:to_i) }
puts "Part 1: #{sensors.map(&diffs).sum}"
puts "Part 2: #{sensors.map(&:reverse!).map(&diffs).sum}"
