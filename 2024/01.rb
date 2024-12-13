digits = $<.map { |line| line.scan(/\d+/).map(&:to_i) }
comp = digits.transpose.map(&:sort).transpose.map { |e| (e[0] - e[1]).abs }
puts "Part 1: #{comp.sum}"

c1, c2 = digits.transpose.map(&:tally)
puts "Part 2: #{c1.map { |k, v| k * v * c2.fetch(k, 0) }.sum}"
