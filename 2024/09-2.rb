map = $<.read.strip.chars.map.with_index { |v,i| [(i.odd? ? nil : i/2), v.to_i]}

a, b = 1, map.size
while b > 0
    b -= 1
    b -= 1 until map[b][0]
    f = map[b]
    next unless a = map.find_index.with_index { |(g,t),i| !g && i<b && t>=f[1] }

    s = map[a]
    map.insert(a+1, [s[0], s[1] - f[1]]) if f[1] < s[1]
    map[a] = f.dup
    f[0] = nil
end

p = -1
sum = map.sum{|f,s|s.times.sum{p+=1;f ?p*f :0}}
print('Part 1: ', sum, "\n")
