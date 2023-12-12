require 'parallel'

memo = {}
input = $<.map do
    a = _1.split
    [a[0], a[1].split(',').map(&:to_i)]
end

consume = lambda { |map, nums, c, buf, num = -1, mi = 0, ni = 0|
    key = map[mi..].hash + [num, c, buf, mi, ni, *nums].hash
    return memo[key] if memo[key]

    return 0 if c && map[mi] != c && map[mi] != '?'
    return 0 if ni >= nums.size && c == '#'

    num -= 1 if c == '#'
    buf -= 1 if c == '.' && map[mi] == '?'
    ok = mi + 1 == map.size && (ni == nums.size || ni + 1 == nums.size && num == 0)
    return 1 if ok
    return 0 if buf < 0

    memo[key] = (
        if num == 0
            consume.(map, nums, '.', buf, -1, mi + 1, ni + 1)
        elsif num > 0
            consume.(map, nums, '#', buf, num, mi + 1, ni)
        else
            (consume.(map, nums, '#', buf, nums[ni], mi + 1, ni) +
            consume.(map, nums, '.', buf, -1, mi + 1, ni))
        end)
}

solve = lambda { |f|
    input.map!.with_index { |(m, n), i| [([m] * f).join('?'), n * f, i] }

    t1 = Time.now
    res = Parallel.map(input, in_processes: 6) do |(map, nums, _i)|
        memo = {}
        todo = nums.sum - map.count('#')
        buf = map.count('?') - todo

        consume.(map, nums, '#', buf, nums[0]) + consume.(map, nums, '.', buf)
    end.sum
    t2 = Time.now
    puts "#{t2 - t1}s"
    res
}

puts "Part 1: #{solve[1]}"
puts "Part 2: #{solve[5]}"
