levels = $<.map { |line| line.scan(/\d+/).map(&:to_i) }

def check(lv, skip = 0)
    lv.each_cons(2).all? { _2 > _1 == lv[1] > lv[0] && (_2 - _1).abs.between?(1, 3) } ? 1 : 0
end
print('Part 1: ', levels.map.sum { check(_1) }, "\n")

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
