map = (input = $<.read).lines
p = input.index('S').then { [_1 % map[0].size, _1 / map[0].size] }
dirs = 'J-7 L|J F-L 7|F'.split # RDLU 0123 i+1
# next: URD RDL DLU LUR          URDL 3012 i/4+i%4

m = ->((x, y), v = !1) { map[y][x] = v || map[y][x] }
step = ->((x, y), d) { [x + (~d + 2) * (~d % 2), y + (2 - d) * (d % 2)] }
stepd = ->(a, d) { [a = step.(a, d), (d + 3 + dirs[d].index(m[a])) % 4] rescue nil }

v = Set.new
vis = -> { v << _1 if m[_1] != '*' }

dist = (0..3).filter_map { stepd.(p, _1) }.then do |(a, d), _|
    (2..).find do
        m[a, '*']
        side = (d - 1) % 4
        next 1 unless n = stepd.(a, d)

        vis.(step.(a, side))
        vis.(step.(n[0], side))
        !(a, d = n)
    end
end

fill = lambda { |a|
    return if m[a] =~ /[\*\#S]/

    m[a, '#']
    (0..3).map { fill.(step.(a, _1)) }
}
v.map(&fill)
puts "Part 1: #{dist / 2}"
puts "Part 2: #{map.join.count('#')}"
