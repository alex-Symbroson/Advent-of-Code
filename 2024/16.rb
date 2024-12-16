require "./Path.rb"

map = *$<
w, h = map[0].size-1, map.size
start, fin, cost = [1,h-2,0], [w-2,1], nil

m = ->((x,y), v = !1) { map[y][x] = v || map[y][x] }
step = ->((x,y), d) { [x + (1-d) * (~d%2), y + (2-d) * (d%2), d] }

next_node_fn = ->(node) {
    next [] if cost && node.cost > cost
    x, y, d = pos = node.pos
    neighbors = 4.times.map{step[pos, _1]}
    neighbors.filter { |a| a[2] != (d+2)%4 && m[a] != '#' }
}

cost_fn = ->((x, y, d), (px, py, pd)) { d == pd ? 1 : 1001 }
goal_test = ->((x, y, d), node) { fin == [x, y] && cost = node.cost }

sols = Dijkstra.search(start, goal_test, cost_fn, next_node_fn, false, true)
puts "Part 1: #{sols[0][0]}"
puts "Part 2: #{sols.map(&:last).flatten(1).map{|(x,y)|[x,y]}.uniq.size}"
# 1.7s
