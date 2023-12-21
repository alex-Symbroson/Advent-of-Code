map = $<.map { _1.tr("\r\n", '').chars }
size = map[0].size + 1i * map.size
one = 1 + 1i

modC = ->(v, m) { v.real % m.real + 1i * (v.imag % m.imag) }
step = ->(p, d) { p + (1 - d) * (~d % 2) + 1i * (2 - d) * (d % 2) }
m = ->(p, v = nil) { map[p.imag][p.real] = v || map[p.imag][p.real] }

vis = Set.new
vis << (size - one) / 2

n = 0
64.times do
    n += 1
    nvis = Set.new
    vis.map do |p|
        4.times do
            q = step[p, _1]
            nvis << q if m[modC[q, size]] != '#'
        end
    end
    vis = nvis
end

puts "Part 1: #{vis.size}"
