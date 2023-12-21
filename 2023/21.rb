map = $<.map(&:chars)
n, w = 26_501_365, map.size

modC = ->((x, y), m) { [x % m, y % m] }
step = ->((x, y), d) { [x + (1 - d) * (~d % 2), y + (2 - d) * (d % 2)] }
m = ->((x, y), v = nil) { map[y][x] = v || map[y][x] }

vis = lvis = Set[[~-w / 2, ~-w / 2]]
r, counts = n % w, [1]

[w - r - 2, r + w].max.times do
    nvis = Set.new
    lvis.map do |p|
        4.times do
            q = step[p, _1]
            nvis << q unless vis === q || m[modC[q, w]] == '#'
        end
    end
    vis += nvis
    lvis = nvis
    counts << (counts[-2] || 0) + nvis.size
end

puts "Part 1: #{counts[64]}"

y1, y2, y3 = counts[w - r - 2], counts[r], counts[r + w]

a = (y3 + y1) / 2 - y2
b = (y3 - y1) / 2
c = y2
x = n / w
puts "Part 2: #{a * x**2 + b * x + c}"
