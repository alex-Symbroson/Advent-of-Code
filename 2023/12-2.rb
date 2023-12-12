require 'parallel'

input = $<.filter_map do
    a = _1.split
    [a[0], a[1].split(',').map(&:to_i)] if _1[0] != ';'
end

tryit = lambda { |map, idx, nums, p, n|
    rega = nums[...p].map { "\#{#{_1}}" }
    regf = Regexp.new("^[.?]*#{rega.join('[.?]+')}[.?]*$")
    rega += ["\#{0,#{nums[p]}}"]
    reg = Regexp.new("^[.?]*#{rega.join('[.?]+')}[.?]*")
    p map

    res = 0
    for i in (p...idx.count)
        m = map.dup
        m[idx[i]] = 35
        p([i, m[0..idx[i] + 1] =~ reg, m[0..idx[i] + 1], reg]) if m.start_with?('.#?..#?...###')
        if i == idx.count - 1
            res += 1 if m =~ regf
        elsif m =~ reg
            res += tryit.(m, idx, nums, i + 1, n - 1)
        end
    end
    res
}

consume = lambda { |map, nums, c, num = -1, mi = 0, ni = 0|
    # p(['--', mi, ni, num, c, map[mi], mi == map.size, c && map[mi] != c]) if mi == map.size
    return 0 if c && map[mi] != c && map[mi] != 63
    return 0 if ni >= nums.size && c == 35

    tc = map[mi]
    map[mi] = c

    num -= 1 if c == 35
    ok = mi + 1 == map.size && (ni == nums.size || ni + 1 == nums.size && num == 0)
    # p(['==', map.pack('c*'), ni, num, mi]) if ok
    map[mi] = tc if ok
    return 1 if ok

    # p([mi, ni, num, c, map])

    res = if num == 0
              consume.(map, nums, 46, -1, mi + 1, ni + 1)
          elsif num > 0
              consume.(map, nums, 35, num, mi + 1, ni)
          else
              consume.(map, nums, 35, nums[ni], mi + 1, ni) +
                  consume.(map, nums, 46, -1, mi + 1, ni)
          end
    map[mi] = tc
    res
}

f = 5
input.map!.with_index { |(m, n), i| [((m + '?') * f)[..-2], n * f, i] }
n = 0
mutex = Mutex.new

res = Parallel.map(input, in_threads: 8) do |(map, nums, i)|
    map = map.bytes
    idx = map.filter_map.with_index { _2 if _1 == 63 }
    # tryit.(map, idx, nums, 0, map.count(63))
    t1 = Time.now
    res = consume.(map, nums, 35, nums[0]) +
          consume.(map, nums, 46)
    t2 = Time.now
    mutex.synchronize do
        p "[#{i}] #{n += 1}/#{input.size} #{res} (#{(t2 - t1).round(3)}s)"
    end
    res
end.sum

puts "Part 2: #{res}"
# puts "Part 2: #{solve[999_999]}"
