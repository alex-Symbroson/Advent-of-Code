map = *$<#.map(&:chars)
g,d,w,h = [0,0], 3, map[0].size, map.size
g[1] = map.index { |l| g[0] = l.index('^') }
cg, cmap = g.dup, map.map(&:dup)

m = ->((x, y), v = !1) { map[y][x] = v || map[y][x] }
step = ->((x, y), d) { [x + (~d + 2) * (~d % 2), y + (2 - d) * (d % 2)] }

walk = ->() {
    count = 1
    while g[0] > 0 && g[1] > 0
        d = (d + 1) % 4 while m[step[g, d]] == '#'
        g = step[g, d]
        count += 1 if m[g] == '.'
        break count = 0 if m[g] == ">v<^"[d]
        m[g, ">v<^"[d]]
    end rescue 0
    count
}

print('Part 1: ', walk[], "\n")

wmap = map.map(&:dup)
part2 = h.times.sum { |b|
    w.times.sum { |a|
        next 0 if cmap[b][a] != '.' || wmap[b][a] == '.'
        d, g, map = 3, cg.dup, cmap.map(&:dup)
        map[b][a] = '#'
        walk[] == 0 ? 1 : 0
    }
}

print('Part 2: ', part2, "\n") # 22s
