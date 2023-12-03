input = File.readlines('input.txt')
res = []
map = {}
sum = 0

for i in 0...input.length
    line = input[i]
    offset = 0
    while m = line.match(/\d+/, offset)
        offset = m.end(0) + 1
        num = $&.to_i
        range = [m.begin(0) - 1, 0].max...(m.end(0) + 1)
        part = nil
        part = [$&, $~] if i > 0 && input[i - 1][range].match(/[^\d\n.]/)
        part = [$&, $~] if input[i][range].match(/[^\d\n.]/)
        part = [$&, $~] if i < input.length - 1 && input[i + 1][range].match(/[^\d\n.]/)
        next unless part

        res.push(num)

        # part 2
        m = part[1]
        key = "#{i - 1},#{m.begin(0) + range.begin}"
        if part[0] == '*' && map[key] && map[key] != -1
            sum += map[key] * num
            map[key] = -1
        else
            map[key] = num
        end
    end
end

print('Part 1: ', res.sum, "\n")
print('Part 2: ', sum)
