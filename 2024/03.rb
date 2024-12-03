input = $<.flat_map { _1.scan(/(do|don't)\(\)|mul\((\d+),(\d+)\)/) }
mul = lambda { _1[1].to_i * _1[2].to_i}

part1 = input.map.sum(&mul)
print('Part 1: ', part1, "\n")

enbl = true
part2 = input.map.sum { |d|
    enbl = d[0] == "do" if !d[0].nil?
    enbl ? mul[d] : 0
}
print('Part 2: ', part2, "\n")
