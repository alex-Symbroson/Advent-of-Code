input = $<.flat_map { _1.scan(/(do|don't)\(\)|mul\((\d+),(\d+)\)/) }
mul = lambda { _1[1].to_i * _1[2].to_i}

print('Part 1: ', input.sum(&mul), "\n")

enbl = true
part2 = input.sum { |d|
    enbl = d[0] == "do" if !d[0].nil?
    enbl ? mul[d] : 0
}
print('Part 2: ', part2, "\n")
