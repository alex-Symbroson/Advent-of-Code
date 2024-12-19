towels, patterns = $<.read.split("\n\n").map{_1.split(/\n|, /)}

fill = ->(pattern) {
    next true if pattern.empty?
    towels.any?{
        fill.(pattern[_1.size..]) if pattern.start_with?(_1)
    }
}

puts "Part 1: #{patterns.count(&fill)}"

map = {}
fill = ->(pattern) {
    next map[pattern] if map[pattern]
    next 1 if pattern.empty?
    map[pattern] = towels.sum{
        pattern.start_with?(_1) ? fill.(pattern[_1.size..]) : 0
    }
}

puts "Part 2: #{patterns.sum(&fill)}"
