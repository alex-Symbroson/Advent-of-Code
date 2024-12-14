list = $<.map{_1.scan(/[-\d]+/).map(&:to_i)}
w, h = 101, 103
wq, hq = w/2+1, h/2+1
mx, my = Hash.new(0),Hash.new(0)

step = ->(v, d=1) {
    v[0] = (v[0] + d*v[2]) % w
    v[1] = (v[1] + d*v[3]) % h
    mx[v[0]] += 1
    my[v[1]] += 1
}

crt = ->(mods, rems) {
    max = mods.inject(:*)
    rems.zip(mods).map{_1.step(max, _2).to_a }.inject(:&).first
}

list.each { step[_1, 100] }

sums = list.map { |(x,y)|
    y/hq*2 + x/wq if x!=wq-1 && y!=hq-1
}.compact.tally

puts "Part 1: #{sums.values.reduce(&:*)}"

l = []
part2 = (101..).each {
    mx.clear
    my.clear
    list.each(&step)
    l << _1 if mx.values.max > 30 || my.values.max > 30
    break if l.size == 2
}

puts "Part 2: #{crt[[h,w], l]}"
