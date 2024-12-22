input = $<.map(&:to_i)

shift = ->(n) {
    n = (n^n*64)%16777216
    n = (n^n/32)%16777216
    n = (n^n*2048)%16777216
}

i,lastP,lastM = 0, Array.new(20**4), Array.new(20**4)
lastP.fill(0)
part1 = input.sum { |n|
    h, i = 84210, i+1 # [0,0,0,0]
    2000.times {
        d0, n = n%10, shift[n]
        d = d0 - n%10 + 10
        h = (20*h + d) % (20**4)
        next if _1 < 3 || i == lastM[h]
        lastP[h] = lastP[h] + n%10
        lastM[h] = i
    }
    n
}

puts "Part 1: #{part1}"
puts "Part 2: #{lastP.sort.last}"
