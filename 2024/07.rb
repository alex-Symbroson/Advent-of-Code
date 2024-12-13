lines = $<.map{_1.scan(/\d+/).map(&:to_i)}

calc = ->(r) {
    lines.sum { |(s, *l)|
        (r ** (l.size-1)).times.any? { |m|
            s == l.each.with_index.reduce { |(a,ai), (b,bi)|
                f = (m / r ** (bi - 1)) % r
                d = b < 10 ? 10 : (b < 100 ? 100 : 1000)
                f==0 ? a+b : (f==1 ? a*b : a*d+b)
            }
        } ? s : 0
    }
}

puts "Part 1: #{calc[2]}" #  1s
puts "Part 2: #{calc[3]}" # 90s
