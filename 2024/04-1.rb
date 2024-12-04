input = *$<
h,w = input.length,input[0].length

check = lambda{ |x,y,a,b|
    "XMAS".chars.all? {
        break if !y.between?(0, h-1)
        break if input[y][x] != _1
        x += a
        y += b
    } ? 1 : 0
}

part1 = h.times.sum { |y|
    w.times.sum { |x|
        9.times.sum { check[x, y, _1%3-1, _1/3-1] }
    }
}

print('Part 1: ', part1, "\n")
