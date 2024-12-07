lines = $<.map{_1.scan(/\d+/).map(&:to_i)}

part1 = lines.sum { |(s,*l)| (2**(l.size-1)).times.any? { |m|
    s == l.each.with_index.reduce { |(a,ai), (b,bi)|
        (m >> (bi-1)) % 2 == 0 ? a+b : a*b
        # [a+b, a*b][(m >> (bi-1)) % 2]
    }
} ? s : 0}

print('Part 1: ', part1, "\n")

part2 = lines.sum { |(s,*l)|
    (3**(l.size-1)).times.any? { |m|
        s == l.each.with_index.reduce { |(a,ai), (b,bi)|
            f = (m / 3**(bi - 1)) % 3
            d = b < 10 ? 10 : (b < 100 ? 100 : 1000)
            f==0 ? a+b : (f==1 ? a*b : a*d+b)
            #[a+b, a*b, a*d+b][f]
        }
    } ? s : 0
}

print('Part 2: ', part2, "\n") # 90s
