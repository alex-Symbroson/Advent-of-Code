map = $<.read.split(" ").map(&:to_i).tally

b = ->(v) {
    if v == 0 then [1]
    elsif v == 1 then [2024]
    elsif (s = v.to_s.size).odd? then [v*2024]
    else
        d = 10**(s/2)
        [v/d, v%d]
    end
}

s = ->(i) {
    step = map.map { |k,v| b[k].tally.transform_values{v*_1}}
    map = {}.merge(*step) {_2 + _3}
}

25.times(&s)
puts "Part 1: #{map.values.sum}"
50.times(&s)
puts "Part 2: #{map.values.sum}"
