inR = ->(v, a, b) { v >= [a, b].min && v <= [a, b].max }

bricks = $<.map { _1.split('~').map { |p| p.split(',').map(&:to_i) } }
bricks.sort! { |a, b| a[0][2] - b[0][2] }

its = lambda { |a, b|
    (ax1, ay1), (ax2, ay2) = a
    (bx1, by1), (bx2, by2) = b

    [ax1, bx1].max <= [ax2, bx2].min &&
        [ay1, by1].max <= [ay2, by2].min;
}

supp = []

bricks.map.with_index do |a, _i|
    below = bricks.map.with_index.filter { |b, _| b[1][2] < a[0][2] && its.(a, b) }
    loop do
        dropped = below.filter_map { |b, j| j if a[0][2] - 1 <= b[1][2] }
        break supp << dropped if a[0][2] <= 1 || !dropped.empty?

        a[0][2] -= 1
        a[1][2] -= 1
    end
end

hold = supp.map { [] }
supp.map.with_index { |l, i| l.map { hold[_1] << i } }
puts "Part 1: #{supp.size.times.count { |i| hold[i].none? { (supp[_1] - [i]).empty? } }}"

# Part 2 WIP

# p(supp.map { |l| l.map { 'ABCDEFGH'[_1] }.join })
# p(hold.map { |l| l.map { 'ABCDEFGH'[_1] }.join })

safe = (0...supp.size).filter { |i| !(supp[i] - [i]).empty? }
puts "Part 1: #{safe.size}"
nsafe = 0

sum = (0...supp.size).to_a.sum do |i|
    next (nsafe += 1; p i if i < 20; 0) if hold[i].map { p([i, supp[_1]]) if i < 20; supp[_1].size > 1 }

    vis = Set.new
    queue = hold[i]
    while j = queue.pop
        next if hold[j].none? { (supp[_1] - [j]).empty? }

        vis << j
        queue += hold[j].filter { !(vis === _1) }
    end
    # puts "#{i} #{vis.size}" if i < 10
    # p vis.to_a unless vis.empty?
    vis.size
end
puts "Part 1: #{nsafe}"

if sum < 87_123 && sum > 1122 && sum != 40_803 && sum != 39_968
    puts "Part 2: #{sum}"
else
    p sum
end
