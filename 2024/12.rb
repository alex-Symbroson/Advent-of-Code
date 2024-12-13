map = $<.map(&:chars)
w, h = map[0].size-1, map.size
dirs = [[-1,0], [1,0], [0,1], [0,-1]]

l = [[0, 0, map[0][0]]]
edges = []
fill = ->(x,y,s,r) {
    next 1 if y<0 || x<0 || y>=h || x>=w
    next 0 if map[y][x] == s.downcase
    next 1 if map[y][x] == map[y][x].downcase
    next (l << [x,y,map[y][x]]; 1) if map[y][x] != s
    map[y][x] = r
    1i + dirs.each.with_index.sum { |(dx,dy), d|
        t = fill[x+dx, y+dy, s,r]
        edges << [x+dx, y+dy, d] if t == 1
        t
    }
}

dist = ->((a,b), (c,d)) { (a-c).abs + (b-d).abs }
countMergable = ->(edges) {
    edges.repeated_permutation(2).count {
        |e,f| e[2] == f[2] && dist[e,f] == 1
    } / 2
}

m = []
while e = l.pop do
    edges.clear
    r = fill[*e, e[2].downcase]
    m << [e[2], r.imag, r.real, countMergable[edges]]
end

print('Part 1: ', m.sum{_2*_3}, "\n")
print('Part 2: ', m.sum{_2*(_3-_4)}, "\n")
