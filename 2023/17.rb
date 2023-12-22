require '.\Astar'
$stdout.sync = true

map = $<.map { _1.tr("\n", '').chars.map(&:to_i) }
$dir2 = ->(((a, b), (c, d))) { [c - a, d - b] }
$m = ->((x, y)) { map[y][x] }
inR = ->(v, a, b) { v >= a != v > b }
w, h = map[0].size, map.size

$printmap = lambda { |path|
    map2 = map.map(&:join)
    path.map { |(x, y)| map2[y][x] = '.' }
    puts map2.join("\n") + "\n\n"
}

$npath = 3
# $npath = 10

next_node_fn = lambda do |node, _cost, prev|
    x, y, d = node
    lx, ly = prev || [-1, 0]
    dx, dy = x - lx, y - ly
    neighbors = []

    neighbors << [x + dx, y + dy, d + 1] if d < 2
    neighbors << [x + dy, y + dx, 0]
    neighbors << [x - dy, y - dx, 0]

    neighbors.filter { |ax, ay| inR[ax, 0, w - 1] && inR[ay, 0, h - 1] }
end

Node = Struct.new(:pos, :dir, :prev, :cost)
def makePath(node, n = 1e9, key = :pos)
    path = [node[key]]
    while node.prev && (n -= 1) > 0
        node = node.prev
        path << node[key]
    end
    path.reverse!
end

def find_path(src_node, goal_test, cost_fn, next_node_fn)
    visited = Set.new
    costs = {}
    queue = PQueue.new { |(c1, _n1), (c2, _n2)| c1 < c2 }

    makekey = ->(node1) { node1.pos.hash ^ node1.dir.hash }

    queue << [0, Node.new(src_node, [0, 0], nil, 0)]
    until queue.empty?
        cost, node = queue.pop
        return [cost, makePath(node)] if goal_test[node.pos]
        next if visited.include?(makekey[node])

        visited << makekey[node]
        for next_pos in next_node_fn[node.pos, node.cost, node.prev&.pos]
            dir = $dir2[[node.pos, next_pos]]
            next_node = Node.new(next_pos, dir, node, 0)

            prev_cost = costs[makekey[next_node]]
            next_cost = cost + cost_fn[next_pos]
            next_node.cost = next_cost

            if !prev_cost || next_cost < prev_cost
                costs[makekey[next_node]] = next_cost
                queue << [next_cost, next_node]
            end
        end
    end
    nil
end

start_node = [0, 0, 0]
end_node = [w - 1, h - 1]
# heuristic = ->((x, y)) {  - ((x - end_node[0]).abs + (y - end_node[1]).abs) / end_node.sum }
cost_fn = ->((x, y)) { map[y][x] }
goal_test = ->((x, y)) { end_node == [x, y] }

cost, path = find_path(start_node, goal_test, cost_fn, next_node_fn)

puts puts "Part 1: #{cost}"
# p path
# $printmap[path]
