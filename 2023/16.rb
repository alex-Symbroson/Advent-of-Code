chars = '.-|\\/#'
map = $<.read.tr("\r", '').split("\n").map { |l| l.chars.map { chars.index(_1) << 4 } }
base = map.map(&:clone).clone
w, h = map[0].size, map.size

step = ->((x, y), d) { [x + (1 - d) * (~d % 2), y + (2 - d) * (d % 2)] }
m = ->((x, y), v = nil) { map[y][x] = v || map[y][x] }
inR = ->(v, a, b) { v >= a != v > b }

# mirror matrix
# d\r|  0-  1|  2\ 3/
# ---+--------------
#  0 |  0  1,3  1  3
#  1 | 0,2  1   0  2
#  2 |  2  3,1  3  1
#  3 | 2,0  3   2  0

cast = lambda do |p, d|
    loop do
        x, y = p = step[p, d]
        # check range and visited direction
        return if !inR.(x, 0, ~-w) || !inR.(y, 0, ~-h) || (m[p] >> d).odd?

        m[p, m[p] | (1 << d)]
        # loop until mirror
        next if m[p] >> 4 == 0

        # apply mirror matrix
        r = ((m[p] >> 4) - 1)
        s = [d + 1, d + 3]
        s.reverse! if d.odd?
        t = r == d % 2 ? [d] : (r > 1 ? [s[r - 2]] : s)

        # reuse single ray
        cast[p, t[1] % 4] if t.size > 1
        d = t[0] % 4
    end
end

cast[[-1, 0], 0]
puts "Part 1: #{map.sum { |l| l.sum { _1 % 16 == 0 ? 0 : 1 } }}"

max = (0...w).flat_map do |i|
    [[i, -1, 1], [-1, i, 0], [w - i - 1, h, 3], [w, h - i - 1, 2]].map do |x, y, d|
        map = base.map(&:clone).clone
        cast[[x, y], d]
        map.sum { |l| l.sum { _1 % 16 == 0 ? 0 : 1 } }
    end
end.max

puts "Part 2: #{max}"
