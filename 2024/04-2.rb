input = $<.map{_1}
search = "MAS"
h,w = input.length,input[0].length-1

check = lambda{|x,y,a,b|
    for i in 0..search.length
        break if !y.between?(0, h-1)
        break if input[y][x] != search[i]
        x += a
        y += b
    end
    i == search.length
}

count = 0
for y in 1...h-1
    for x in 1...w-1
        count += 1 if
            [-1,1].any?{|a| check[x-a,y-a,a,a]} &&
            [-1,1].any?{|a| check[x-a,y+a,a,-a]}
    end
end

print('Part 2: ', count, "\n")
