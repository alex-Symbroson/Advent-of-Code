require 'pqueue'

module Astar
    Node = Struct.new(:state, :cost, :heuristic, :path)

    def self.search(start_state, goal_test, next_states_fn, cost_fn, &heuristic_fn)
        pq = PQueue.new([Node.new(start_state, 0, heuristic_fn.(start_state), [])]) do |a, b|
            b.cost <=> a.cost
        end
        seen = {}

        until pq.empty?
            current_node = pq.pop
            return [current_node.cost, current_node.path + [current_node.state]] if goal_test.(current_node.state)

            next_states_fn.(current_node.state, current_node.cost, current_node.path).each do |next_state|
                next_node = Node.new(
                    next_state,
                    current_node.cost + cost_fn.(next_state),
                    heuristic_fn.(next_state),
                    current_node.path + [current_node.state]
                )
                next unless !seen.include?(next_state) || next_node.cost < seen[next_state]

                pq.push(next_node)
                seen[next_state] = next_node.cost
            end
        end

        nil
    end
end

module Dijkstra
    Node = Struct.new(:pos, :dir, :prev, :cost, :len)

    def self.search(src_node, goal_test, cost_fn, next_node_fn)
        visited = Set.new
        costs = {}
        queue = PQueue.new { |(c1, _n1), (c2, _n2)| c1 < c2 }

        makekey = ->(node1) { node1.pos.hash ^ node1.dir.hash }

        queue << [0, Node.new(src_node, [0, 0], nil, 0, 0)]
        until queue.empty?
            cost, node = queue.pop
            return [cost, makePath(node)] if goal_test[node.pos]
            next if visited.include?(makekey[node])

            visited << makekey[node]
            for next_pos in next_node_fn[node.pos, node.cost, node.prev&.pos, node.len]
                dir = $dir2[[node.pos, next_pos]]
                next_node = Node.new(next_pos, dir, node, 0, node.len + 1)

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
end

=begin

map = %w[
    ..#..
    #.#.#
    ..#..
    .#.#.
    .....
]

start_node = [0, 0]
goal_test = ->(node) { node == [4, 0] }
next_node_fn = lambda do |node|
    x, y = node
    neighbors = []

    neighbors << [[x + 1, y], 2]  if x + 1 < map[0].length
    neighbors << [[x - 1, y], 2]  if x - 1 >= 0
    neighbors << [[x, y + 1], 1]  if y + 1 < map.length
    neighbors << [[x, y - 1], 1]  if y - 1 >= 0

    neighbors.select { |(nx, ny), _| map[ny][nx] == '.' }
end
heuristic = ->(_node) { 1 }

p Astar.search(start_node, goal_test, next_node_fn, &heuristic)
=end
