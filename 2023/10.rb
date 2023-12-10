$map = map = (input = $<.read).lines
p = input.index('S').then { [_1 % map[0].size, _1 / map[0].size] }
dirs = 'J-7 L|J F-L 7|F'.split # RDLU 0123 i+1
# next: URD RDL DLU LUR          URDL 3012 i/4+i%4

step = ->((x, y), d) { [x + (~d + 2) * (~d % 2), y + (2 - d) * (d % 2)] }
stepd = ->(a, d) { [a = step.(a, d), (d + 3 + dirs[d].index(map[a[1]][a[0]])) % 4] rescue nil }

vis = Set.new
dist = (0..3).filter_map { stepd.(p, _1) }.then do |(a, d), _|
    (2..).find do
        vis -= [a]
        map[a[1]][a[0]] = '*'
        side = (d - 1) % 4
        next 1 unless n = stepd.(a, d)

        fa = step.(a, side)
        vis << fa if $map[fa[1]][fa[0]] != '*'

        fa = step.(n[0], side)
        vis << fa if map[fa[1]][fa[0]] != '*'
        !(a, d = n)
    end
end

fill = lambda { |x, y|
    return if map[y][x] =~ /[\*\#S]/

    map[y][x] = '#'
    (0..3).map { fill.(*step.([x, y], _1)) }
}
vis.map { |a| fill.(*a) }
puts "Part 1: #{dist / 2}"
puts "Part 2: #{$map.join.count('#')}"
