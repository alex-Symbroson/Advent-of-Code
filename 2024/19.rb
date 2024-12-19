towels, patterns = $<.read.split("\n\n").map{_1.split(/\n|, /)}

map = {}
fill = ->(pattern) {
    map[pattern] ||= pattern == "" ? 1 : towels.sum {
        pattern.start_with?(_1) ? fill.(pattern[_1.size..]) : 0
    }
}

puts "Part 1: #{patterns.count{fill[_1]>0}}"
puts "Part 2: #{patterns.sum(&fill)}"
