require '.\Path'
$stdout.sync = true

map = $<.map { _1.tr("\n", '').chars.map(&:to_i) }
$dir2 = ->(((a, b), (c, d))) { [c - a, d - b] }
$m = ->((x, y)) { map[y][x] }
inR = ->(v, a, b) { v >= a != v > b }
w, h = map[0].size, map.size

$printmap = lambda { |path|
    map2 = map.map(&:join)
    path&.map { |(x, y)| map2[y][x] = '.' }
    puts map2.join("\n") + "\n\n"
}

next_node_fn = lambda do |node, _cost, prev, len|
    x, y, d = node
    lx, ly = prev || [-1, 0]
    dx, dy = x - lx, y - ly
    neighbors = []

    neighbors << [x + dx, y + dy, d + 1] if d < $tmax - 2
    neighbors << [x + dy, y + dx, 0] if d >= $tmin - 1 || len <= $tmin + 1
    neighbors << [x - dy, y - dx, 0] if d >= $tmin - 1 || len <= $tmin + 1

    neighbors.filter { |ax, ay| inR[ax, 0, w - 1] && inR[ay, 0, h - 1] }
end

def makePath(node, n = 1e9, key = :pos)
    path = [node[key]]
    while node.prev && (n -= 1) > 0
        node = node.prev
        path << node[key]
    end
    path.reverse!
end

start_node = [0, 0, 0]
end_node = [w - 1, h - 1]
cost_fn = ->((x, y)) { map[y][x] }
goal_test = ->((x, y)) { end_node == [x, y] }

$tmin, $tmax = 0, 4
cost, path = Dijkstra.search(start_node, goal_test, cost_fn, next_node_fn)
puts "Part 1: #{cost}"

$tmin, $tmax = 4, 10
cost, path = Dijkstra.search(start_node, goal_test, cost_fn, next_node_fn)
if cost > 1196 && cost < 1227 && cost != 1221 && cost != 1221 && cost != 1219 && cost != 1217
    puts "Part 2: #{cost}"
else
    puts cost
end
