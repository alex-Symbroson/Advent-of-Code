input = $<.read
sp = input.index('S')
$map = map = input.lines
p = [sp % map[0].size, sp / map[0].size]
dirs = 'J-7 L|J F-L 7|F'.split # RDLU 0123 i+1
# next: URD RDL DLU LUR          URDL 3012 i/4+i%4

def pm(ax, ay, ad)
    m = $map
    m[ay][ax] = '>v<^'[ad]
    # puts $map.join.tr('FJL7|-', ' ')
    # sleep(0.06)
end

step = lambda { |x, y, d|
    [
        x += (~d + 2) * (~d % 2),
        y += (2 - d) * (d % 2),
        (d + 3 + dirs[d].index(map[y][x])) % 4
    ] rescue nil
}

dist = (0..3).filter_map { step.(*p, _1) }.then do |a, _b|
    (2..).find do
        pm(*a)
        !(a = step.(*a))
    end
end

# puts $map.join.tr('FJL7|-', '#')
puts "Part 1: #{dist / 2}"

# puts "Part 2: #{sensors.map(&:reverse!).map(&diffs).sum}"
