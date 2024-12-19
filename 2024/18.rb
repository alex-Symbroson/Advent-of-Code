require './Path.rb'

bytes = $<.map{_1.split(",").map(&:to_i)}
w,h,n = 71,71,1024
map = Array.new(h).map{'.'*w}

m = ->((x,y), v = !1) { v ? map[y][x] = v : map[y][x] rescue nil }
step = ->((x,y), d) { [x + (1-d) * (~d%2), y + (2-d) * (d%2)] }

start,fin = [0,0],[w-1,h-1]
cost_fn = ->(*_) { 1 }
goal_test = ->(v, *_) { fin == v }
next_node_fn = ->(pos, *_) {
    4.times.map{step[pos, _1]}
        .filter{|(x,y)| x>=0 && y>=0 }
        .filter{m[_1] == '.'}
}

n.times{m[bytes[_1],'#']}
cost,path = Dijkstra.search(start, goal_test, cost_fn, next_node_fn)

puts "Part 1: #{cost}"

part2 = (n...bytes.size).bsearch {|i|
    i.times{m[bytes[_1],'#']} # i excluded
    cost,path = Dijkstra.search(start, goal_test, cost_fn, next_node_fn)
    i.times{m[bytes[_1],'.']}
    !cost
}
puts "Part 2: #{bytes[part2-1].join(',')}"
