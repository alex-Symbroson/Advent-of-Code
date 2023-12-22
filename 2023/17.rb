require '.\Astar'
$stdout.sync = true

map = $<.map { _1.tr("\n", '').chars.map(&:to_i) }
$dir2 = ->(((a, b), (c, d))) { [c - a, d - b] }
$m = ->((x, y)) { map[y][x] }
w, h = map[0].size, map.size

$printmap = lambda { |path|
    map2 = map.map(&:join)
    path.map { |(x, y)| map2[y][x] = '.' }
    puts map2.join("\n") + "\n\n"
}

$npath = 3
# $npath = 10

next_node_fn = lambda do |node, _cost, path|
    x, y = node
    lx, ly = path[-2] || [-1, 0]
    neighbors = []
    same1 = path[~$npath..].each_cons(2).map(&$dir2).uniq if path && path.size > $npath
    same = same1 && same1.size == 1 ? same1[0] : nil

    neighbors << [x + 1, y] if same != [1, 0] && lx - x != 1 && x + 1 < w
    neighbors << [x - 1, y] if same != [-1, 0] && lx - x != -1 && x - 1 >= 0
    neighbors << [x, y + 1] if same != [0, 1] && ly - y != 1 && y + 1 < h
    neighbors << [x, y - 1] if same != [0, -1] && ly - y != -1 && y - 1 >= 0

    neighbors
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

    makekey = lambda { |node1|
        path2 = makePath(node1, $npath, :dir)
        [node1.pos, node1.dir, *path2].hash # , same1 ? same1.size : 0].hash
    }

    queue << [0, Node.new(src_node, [0, 0], nil, 0)]
    until queue.empty?
        cost, node = queue.pop

        if goal_test[node.pos]
            tnode = node.clone
            tpath = ["#{tnode.pos} #{$m[tnode.pos]} #{tnode.cost}"]
            while tnode.prev
                tnode = tnode.prev
                tpath << "#{tnode.pos} #{$m[tnode.pos]} #{tnode.cost}"
            end
            # puts tpath.reverse.join("\n")
        end
        return [cost, makePath(node)] if goal_test[node.pos]
        next if visited.include?(makekey[node])

        # puts cost
        # $printmap[makePath(node), cost]
        # sleep(0.05)

        visited << makekey[node]
        for next_pos in next_node_fn[node.pos, node.cost, makePath(node, $npath + 1)]
            dir = $dir2[[node.pos, next_pos]]
            next_node = Node.new(next_pos, dir, node, 0)

            prev_cost = costs[makekey[next_node]]
            next_cost = cost + cost_fn[next_pos]
            next_node.cost = next_cost

            # puts "test #{next_pos} #{cost} -> #{next_cost} < #{prev_cost}: #{!prev_cost || next_cost < prev_cost}"
            if !prev_cost || next_cost < prev_cost
                costs[makekey[next_node]] = next_cost
                queue << [next_cost, next_node]
            end
        end
        # puts "\n\n"
    end
    nil
end

start_node = [0, 0]
end_node = [map[0].size - 1, map.size - 1]
# heuristic = ->((x, y)) {  - ((x - end_node[0]).abs + (y - end_node[1]).abs) / end_node.sum }
cost_fn = ->((x, y)) { map[y][x] }
goal_test = ->(p) { p == end_node }

cost, path = find_path(start_node, goal_test, cost_fn, next_node_fn)
# cost, path = Astar.astar_search(start_node, goal_test, next_node_fn, cost_fn, &heuristic)

puts cost
p path
$printmap[path]

# puts "Part 1: #{input.sum(&hash)}"
# puts "Part 2: #{boxes.sum { |(i, b)| i * b.map.with_index.sum { |l, j| -~j * l[1] } }}"
# < 1002
