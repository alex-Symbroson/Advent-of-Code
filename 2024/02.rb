levels = $<.map { |line| line.scan(/\d+/).map(&:to_i) }

check = ->(lv) {
    lv.each_cons(2).all? { _2 > _1 == lv[1] > lv[0] && (_2 - _1).abs.between?(1, 3) }
}
puts "Part 1: #{levels.map.count { check[_1] }}"

part2 = levels.map.count { |level|
    level.size.times.any? { |i|
        check[level[...i] + level[i+1..]]
    }
}
puts "Part 2: #{part2}"
