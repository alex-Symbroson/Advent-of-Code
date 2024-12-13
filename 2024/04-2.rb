input = *$<
h,w = input.length,input[0].length

check = ->(x,y,a,b) {
    "MAS".chars.all? {
        next if !y.between?(0, h-1)
        next if input[y][x] != _1
        x += a
        y += b
    }
}

part2 = h.times.sum{ |y|
    w.times.count{ |x|
        [-1,1].any?{|a| check[x-a,y-a,a,a]} &&
        [-1,1].any?{|a| check[x-a,y+a,a,-a]}
    }
}

print('Part 2: ', part2, "\n")
