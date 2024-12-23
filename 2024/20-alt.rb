require 'time'
t0 = Time.now

map = *$<
s,d,w,h = [0,0], 3, map[0].size, map.size
s[1] = map.index { |l| s[0] = l.index('S') }
cmap = map.map(&:dup)

m = ->((x,y), v = !1) { v ? map[y][x] = v : map[y][x] rescue nil }
step = ->((x,y), d) { [x + (1-d) * (~d%2), y + (2-d) * (d%2)] }

path = []
while s
    path << s
    m[s,"O"]
    s = 4.times.map{step[s, _1]}.find{".E".index(m[_1])}
end
order = path.map.with_index.to_h

solve = ->(n) {
    shorts = Hash.new(0)
    path.each { |(x,y)|
        (-n..n).each{|dy|
            y2 = y+dy
            next if y2<0 || y2>=h
            (dy.abs-n..n-dy.abs).each{|dx|
                x2 = x+dx
                next if !order[[x2,y2]]
                d = order[[x2,y2]] - order[[x,y]] - (x2-x).abs - (y2-y).abs
                shorts[d] += 1 if d > 0
            }
        }
    }
    shorts.sum { _1 >= 100 ? _2 : 0}
}

STDOUT.sync = true
puts "Part 1: #{solve[2]}"
puts "Part 2: #{solve[20]}"
