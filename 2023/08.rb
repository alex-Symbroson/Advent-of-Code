run, _, *maps = $<.map { _1.split(/\W+/) }
maps = maps.group_by(&:first)
run = run[0].tr('LR', "\1\2").bytes

move = lambda do |pos, &cond|
    i = n = 0
    until cond[pos]
        pos = maps[pos][0][run[i]]
        i = (i + 1) % run.size
        n += 1
    end
    n
end

puts "Part 1: #{move.('AAA') { _1 == 'ZZZ' }}"
puts "Part 2: #{maps.keys.filter { _1[2] == 'A' }.map { |s| move[s] { _1[2] == 'Z' } }.reduce(&:lcm)}"
