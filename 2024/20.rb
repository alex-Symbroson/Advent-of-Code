require './Path.rb'

map = *$<#.map(&:chars)
s,d,w,h = [0,0], 3, map[0].size, map.size
s[1] = map.index { |l| s[0] = l.index('S') }
cmap = map.map(&:dup)

m = ->((x,y), v = !1) { v ? map[y][x] = v : map[y][x] rescue nil }
step = ->((x,y), d) { [x + (1-d) * (~d%2), y + (2-d) * (d%2)] }

cost_fn = ->(*_) { 1 }
goal_test = ->(v, n) {
    path = Dijkstra.makePath(n)
    path.each{|x,y,c|map[y][x] = c==0?'O':'0'}
    #print "\033[H;\033[H;"
    #print map.join; p; sleep 0.3
    map = cmap.map(&:dup)
    m[v] == 'E'
}

next_node_fn = ->(pos, *_) {
    4.times.map{step[pos, _1]}
        .filter{|(x,y)| x>=0 && y>=0 }
        .filter{".E".index(m[_1])}
}

cost,path = Dijkstra.search(s, goal_test, cost_fn, next_node_fn)
order = {}
path.map.each_cons(2).with_index{|(a,b),c|order[a]=b.dup<<(c+1)}
order[path.last] = path.last.dup<<path.size




shorts = Hash.new(0)


goal_test2 = ->(v, n) { n.cost > 1 && m[v] && ".E".index(m[v]) }

max = 2
next_node_fn2 = ->(pos, node) {
    next [] if node.cost >= max || node.cost > 0 && m[pos] != '#'
    4.times.map{step[pos, _1]}
        .filter{|(x,y)| x>=0 && y>=0}
        .filter{node.cost > 0 && m[_1] != '#' || node.cost < max && m[_1] == '#' }
}


path.each{|pos|
    sols = Dijkstra.search(pos, goal_test2, cost_fn, next_node_fn2, false, true)
    sols.each {|cost,sol|
        next if !order[pos] || !order[sol.last]
        d = order[sol.last][2] - order[pos][2] - (sol.size-1)
        next if d < 1
        # print "#{pos} (#{order[pos]}) -> (#{order[sol.last]}) #{sol[1].last}\n"
        #print "#{d}: #{pos} (#{order[pos][2]}) -> (#{order[sol.last][2]} - #{sol.size-1}) #{sol.last}\n"
        shorts[d] += 1
    }
}
p shorts.sort.to_h
puts "Part 1: #{shorts.sum{_1>=100?_2:0}}"



#skip = true
#sols = Dijkstra.search(s, goal_test, cost_fn, next_node_fn, false, true)
#p sols.size

#puts "Part 2: #{patterns.sum(&fill)}"
