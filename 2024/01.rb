digits = $<.map { |line| line.scan(/\d+/).map { |n| n.to_i } }
sorted = digits.transpose.map { |l| l.sort }
comp = sorted.transpose.map { |e| (e[0] - e[1]).abs }

print('Part 1: ', comp.sum, "\n")

counts = digits.transpose.map { |l| l.tally }
c1 = counts[0]
c2 = counts[1]
c2.default = 0

print('Part 2: ', c1.map {|k,v| k * v * (c2[k]) }.sum)
