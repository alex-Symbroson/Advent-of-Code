map = $<.map{_1.strip.chars.map { |c| c=='.' ? nil : c.to_i}}
w,h = map[0].size, map.size
dirs = [[-1,0], [1,0], [0,-1], [0,1]]
m={}

walk = ->(x, y, v) {
    v == 9 ? x+y*1i : dirs.flat_map { |(dx,dy)|
        y+dy<0 || x+dx<0 || y+dy>=h || map[y+dy][x+dx] != v+1 ? nil : walk[x+dx,y+dy,v+1]
    }
}

part1 = h.times.sum { |y| w.times.sum { |x| map[y][x] == 0 ? walk[x,y,0].compact.uniq.count : 0}}

print('Part 1: ', part1, "\n")

walk2 = ->(x, y, v) {
    v == 9 ? 1 : dirs.sum { |(dx,dy)|
        y+dy<0 || x+dx<0 || y+dy>=h || map[y+dy][x+dx] != v+1 ? 0 : walk2[x+dx,y+dy,v+1]
    }
}

part2 = h.times.sum { |y| w.times.sum { |x| map[y][x] == 0 ? walk2[x,y,0] : 0}}

print('Part 2: ', part2, "\n")
