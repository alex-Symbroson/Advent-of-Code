input = *$<
h,w = input.length,input[0].length

check = ->(x,y,a,b) {
    "XMAS".chars.all? {
        break if !y.between?(0, h-1)
        break if input[y][x] != _1
        x += a
        y += b
    }
}

part1 = h.times.sum { |y|
    w.times.sum { |x|
        9.times.count { check[x, y, _1%3-1, _1/3-1] }
    }
}

puts "Part 1: #{part1}"
