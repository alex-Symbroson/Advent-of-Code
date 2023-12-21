map = $<.map { _1.tr("\r\n", '').chars }
size = map[0].size + 1i * map.size
n, w = 26_501_365, map.size
$stdout.sync = true

modC = ->(v, m) { v.real % m.real + 1i * (v.imag % m.imag) }
step = ->(p, d) { p + (1 - d) * (~d % 2) + 1i * (2 - d) * (d % 2) }
m = ->(p, v = nil) { map[p.imag][p.real] = v || map[p.imag][p.real] }

vis = Set.new
vis << (size - 1 - 1i) / 2
counts = [0]
r = n % w;

(r + 2 * w).times do |i|
    nvis = Set.new
    vis.map do |p|
        4.times do
            q = step[p, _1]
            nvis << q if m[modC[q, size]] != '#'
        end
    end
    vis = nvis
    print "\r#{100 * i / (r + 2 * w)}%"
    counts << vis.size
end

puts
puts "Part 1: #{counts[64]}"

y1, y2, y3 = counts[r], counts[r + w], counts[r + 2 * w]
a = (y1 - 2 * y2 + y3) / 2
b = (-3 * y1 + 4 * y2 - y3) / 2
x = n / w

puts "Part 2: #{a * x**2 + b * x + y1}"
