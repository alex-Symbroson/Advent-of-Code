run, _, *maps = $<.readlines
maps = maps.map { _1.split(/[ =(),\n]+/) }.group_by(&:first)

pos = 'AAA'
i = 0
n = 0
while pos != 'ZZZ'
    d = run[i] == 'R' ? 2 : 1
    pos = maps[pos][0][d]
    i = (i + 1) % (run.size - 1)
    n += 1
end
puts "Part 1: #{n}"

move = lambda  { |pos|
    i = 0
    n = 0
    while pos[2] != 'Z'
        d = run[i] == 'R' ? 2 : 1
        pos = maps[pos][0][d]
        i = (i + 1) % (run.size - 1)
        n += 1
    end
    n
}

p maps.keys.filter { _1[2] == 'A' }
puts "Part 2: #{maps.keys.filter { _1[2] == 'A' }.map(&move).reduce(1, &:lcm)}"
