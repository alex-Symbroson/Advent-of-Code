lines = $<.map(&:strip)
map, h, w = {}, lines.size,lines[0].size

lines.map.with_index { |l, y|
    l.chars.map.with_index { |v, x|
        next if ".\n".include?(v)
        map[v] = [] if !map[v]
        map[v] << x+y*1i
    }
}

ok = ->(v) { v.real.between?(0, w-1) && v.imag.between?(0, h-1) }
calc = ->(r=nil) {
    anti = {}
    map.each { |k, v|
        v.repeated_permutation(2) { |a, b|
            next if a==b
            d = a-b
            n = -1
            if r then
                anti[a+d*n] = 1 while ok[a+d*(n+=1)]
            else
                anti[a+d] = 1 if ok[a+d]
                anti[b-d] = 1 if ok[b-d];
            end
        }
    }
    anti.size
}

puts "Part 1: #{calc[]}"
puts "Part 2: #{calc[1]}"
