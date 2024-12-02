levels = $<.map { |line| line.scan(/\d+/).map(&:to_i) }

def check(level)
    diff = level.each_cons(2).map { |a| a[0] - a[1] }
    (diff.any? { (_1 > 0) != (diff[0] > 0) || _1.abs < 1 || _1.abs > 3 }) ? 0 : 1
end

print('Part 1: ', levels.map.sum {check(_1)}, "\n")

part2 = levels.map.sum { |level|
    res, i = check(level), level.length
    while res == 0 && i >= 0
        (d = level.clone).delete_at(i)
        res = check(d)
        i -= 1
    end
    res
}
print('Part 2: ', part2, "\n")
