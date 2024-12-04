input = *$<
h,w = input.length,input[0].length

check = lambda{|x,y,a,b|
    "MAS".chars.all? {
        break if !y.between?(0, h-1)
        break if input[y][x] != _1
        x += a
        y += b
    }
}

part2 = h.times.sum{ |y|
    w.times.sum{ |x|
        [-1,1].any?{|a| check[x-a,y-a,a,a]} &&
        [-1,1].any?{|a| check[x-a,y+a,a,-a]} ? 1 : 0
    }
}

print('Part 2: ', part2, "\n")
