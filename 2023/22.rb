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
    # p below
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
