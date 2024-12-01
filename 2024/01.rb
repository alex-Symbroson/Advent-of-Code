digits = $<.map { |line| line.scan(/\d+/).map(&:to_i) }
comp = digits.transpose.map(&:sort).transpose.map { |e| (e[0] - e[1]).abs }
print('Part 1: ', comp.sum, "\n")

c1, c2 = digits.transpose.map(&:tally)
print('Part 2: ', c1.map { |k, v| k * v * c2.fetch(k, 0) }.sum)
