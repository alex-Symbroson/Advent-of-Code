map = $<.map { _1.tr("\r\n", '').chars }
n, w = 26_501_365, map.size
$stdout.sync = true

modC = ->((x, y), m) { [x % m, y % m] }
step = ->((x, y), d) { [x + (1 - d) * (~d % 2), y + (2 - d) * (d % 2)] }
m = ->((x, y), v = nil) { map[y][x] = v || map[y][x] }

vis = lvis = Set.new([[~-w / 2, ~-w / 2]])
counts = [1]
r = n % w;

(r + 2 * w).times do
    nvis = Set.new
    lvis.map do |p|
        4.times do
            q = step[p, _1]
            nvis << q unless vis.include?(q) || m[modC[q, w]] == '#'
        end
    end
    vis += nvis
    lvis = nvis
    counts << (counts[-2] || 0) + nvis.size
end

puts "Part 1: #{counts[64]}"

y1, y2, y3 = counts[r], counts[r + w], counts[r + 2 * w]
a = (y1 - 2 * y2 + y3) / 2
b = (-3 * y1 + 4 * y2 - y3) / 2
x = n / w

puts "Part 2: #{a * x**2 + b * x + y1}"
