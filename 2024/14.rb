list = $<.map{_1.scan(/[-\d]+/).map(&:to_i)}
w,h = 101,103
wq,hq = w/2+1, h/2+1
m = Hash.new(0)

step = ->(v) {
    v[0] = (v[0]+v[2]) % w
    v[1] = (v[1]+v[3]) % h
    m[v[0]] += 1
}

100.times { list.map(&step) }

sums = [[0,0],[0,0]]
list.each { |(x,y)|
    next if x==wq-1 || y==hq-1
    sums[y/hq][x/wq] += 1
}

puts "Part 1: #{sums.flatten.reduce(&:*)}"

map = 103.times.map{' '*103}

i=100
while true do
    m.clear
    list.map(&step)
    i+=1

    next unless (i-48)%101 == 0 || (i-23)%103 == 0

    list.each { |v| map[v[1]][v[0]] = '#' }
    break if map.any?{_1.include?("#"*31)}
    list.each { |v| map[v[1]][v[0]] = ' ' }
end

# puts map.join("\n")

puts "Part 2: #{i}"
