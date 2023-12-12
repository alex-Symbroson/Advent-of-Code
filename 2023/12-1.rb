input = $<.map do
    a = _1.split
    [a[0], a[1].split(',').map(&:to_i)]
end

tryit = lambda { |_map, nums, _p, n|
    for i in (0..n - nums.size)
        map[p..]
    end
}

res = input.sum do |(map, nums)|
    reg = Regexp.new(nums.map { "\#{#{_1}}" }.join('[.?]+'))
    n = nums.sum - map.count('#')
    idx = map.chars.filter_map.with_index { _2 if _1 == '?' }
    idx.combination(n).filter_map do |ns|
        m = map.dup
        ns.map { m[_1] = '#' }
        m if m =~ reg
    end.size

    # tryit(map, nums, 0, map.count('?'))
end

puts "Part 1: #{res}"
# puts "Part 2: #{solve[999_999]}"
