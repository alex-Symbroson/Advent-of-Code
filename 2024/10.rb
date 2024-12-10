map = $<.map{_1.strip.chars.map { |c| c=='.' ? nil : c.to_i}}
w,h = map[0].size, map.size
dirs = [[-1,0], [1,0], [0,-1], [0,1]]

walk = ->(x, y, v) {
    v == 9 ? x+y*1i : dirs.flat_map { |(dx,dy)|
        y+dy<0 || x+dx<0 || y+dy>=h || map[y+dy][x+dx] != v+1 ? nil : walk[x+dx,y+dy,v+1]
    }.compact
}

walks = (h*w).times.sum { |x|
    map[x/w][x%w] > 0 ? 0 : (r = walk[x%w,x/w,0]; r.uniq.count+r.count*1i)
}

print('Part 1: ', walks.real, "\n")
print('Part 2: ', walks.imag, "\n")
