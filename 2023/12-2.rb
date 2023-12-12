require 'parallel'

memo = {}
input = $<.filter_map do
    a = _1.split
    [a[0], a[1].split(',').map(&:to_i)] if _1[0] != ';'
end

consume = lambda { |map, nums, c, buf, num = -1, mi = 0, ni = 0|
    key = (map[mi..] + [num, c, buf, mi, ni, *nums]).hash
    return memo[key] if memo[key]

    return 0 if c && map[mi] != c && map[mi] != 63
    return 0 if ni >= nums.size && c == 35

    num -= 1 if c == 35
    buf -= 1 if c == 46 && map[mi] == 63
    ok = mi + 1 == map.size && (ni == nums.size || ni + 1 == nums.size && num == 0)
    return 1 if ok
    return 0 if buf < 0

    memo[key] = (
        if num == 0
            consume.(map, nums, 46, buf, -1, mi + 1, ni + 1) # .
        elsif num > 0
            consume.(map, nums, 35, buf, num, mi + 1, ni) # #
        else
            (consume.(map, nums, 35, buf, nums[ni], mi + 1, ni) + # #
            consume.(map, nums, 46, buf, -1, mi + 1, ni)) # .
        end)
}

f = 5
input.map!.with_index { |(m, n), i| [((m + '?') * f)[..-2], n * f, i] }

t1 = Time.now
res = Parallel.map(input, in_processes: 6) do |(map, nums, _i)|
    memo = {}
    todo = nums.sum - map.count('#')
    buf = map.count('?') - todo

    map = map.bytes
    consume.(map, nums, 35, buf, nums[0]) + consume.(map, nums, 46, buf)
end.sum
t2 = Time.now
puts "#{t2 - t1}s"
puts "Part 2: #{res}"
