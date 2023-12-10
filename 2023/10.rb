input = $<.read
sp = input.index('S')
$map = map = input.lines
p = [sp % map[0].size, sp / map[0].size]
dirs = 'J-7 L|J F-L 7|F'.split # RDLU 0123 i+1
# next: URD RDL DLU LUR          URDL 3012 i/4+i%4

#   0 1 2 3
# x 1 0-1 0
# y 0 1 0-1

def pm(ax, ay, _, bx, by, _)
    m = $map.join.lines
    m[ay][ax] = '#'
    m[by][bx] = '#'
    puts m.join + "\n"
end

step = ->(x, y, d) { [x += (~d + 2) * (~d % 2), y += (2 - d) * (d % 2), (d + 3 + dirs[d].index(map[y][x])) % 4] }

part1 = (0..3).filter_map { step.(*p, _1) rescue nil }.then do |a, b|
    (2..).find do
        a = step.(*a)
        b = step.(*b)
        a[..1] == b[..1]
    end
end
puts "Part 1: #{part1}"

# puts "Part 2: #{sensors.map(&:reverse!).map(&diffs).sum}"
