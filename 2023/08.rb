steps, _, *paths = $<.map { _1.split(/\W+/) }
map = paths.group_by :first
cmds = steps[0].tr('LR', "\1\2").bytes

move = lambda do |pos, &cond|
    i = n = 0
    until cond[pos]
        pos = map[pos][0][cmds[i]]
        i = (i + 1) % cmds.size
        n += 1
    end
    n
end

puts "Part 1: #{move.('AAA') { _1 == 'ZZZ' }}"
puts "Part 2: #{map.keys.filter { _1[2] == 'A' }.map { |s| move[s] { _1[2] == 'Z' } }.reduce :lcm}"
