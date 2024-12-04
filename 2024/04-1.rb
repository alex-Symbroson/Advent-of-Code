input = $<.map{_1}
search = "XMAS"
h,w = input.length,input[0].length-1

check = lambda{|x,y,a,b|
    for i in 0..search.length
        break if !y.between?(0, h-1)
        break if input[y][x] != search[i]
        x += a
        y += b
    end
    i == search.length ? 1 : 0
}

count = 0
for y in 0...h
    for x in 0...w
        count += (0..8).sum { check[x, y, _1%3-1, _1/3-1] }
    end
end

print('Part 1: ', count, "\n")
