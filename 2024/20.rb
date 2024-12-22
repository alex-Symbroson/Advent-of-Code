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

findpaths = ->(n, shorts, paths1, paths2) {
    paths1.each { |x1,y1|
        paths2.each { |x2,y2|
            dist = (x2-x1).abs + (y2-y1).abs
            next if dist > n
            d = order[[x2,y2]]-order[[x1,y1]]-dist
            shorts[d] += 1 if d > 0
        }
    }
}

solve = ->(n) {
    chunks, shorts = {}, Hash.new(0)
    path.each { |x,y| (chunks[[x/n, y/n]] ||= []) << [x,y]}

    chunks.each { |(xc1,yc1), c1fields|
        9.times { |i|
            c2 = [xc1 + i/3-1, yc1 + i%3-1]
            next unless (0..w/n) === c2[0] && (0..h/n) === c2[1]
            c2fields = chunks[c2]
            findpaths[n, shorts, c1fields, c2fields] if c2fields
        }
    }
    shorts.sum { _1 >= 100 ? _2 : 0}
}

STDOUT.sync = true
puts "Part 1: #{solve[2]}"
puts "Part 2: #{solve[20]}"
