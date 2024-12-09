map = $<.read.strip.chars.map.with_index { |v,i| [(i.odd? ? nil : i/2), v.to_i]}

a, b = 1, map.size-1
while a < b
    b -= 1 until map[b][0]
    a += 1 while map[a][0]
    s, f = map[a], map[b]
    m = [s[1], f[1]].min

    map.insert(a+1, [s[0], s[1] - m]) if m < s[1]
    map[a] = [f[0], m]
    f[0] = nil if (f[1] -= m) == 0
end

p = -1
sum = map.sum{|f,s|s.times.sum{p+=1;f ?p*f :0}}
print('Part 1: ', sum, "\n")
