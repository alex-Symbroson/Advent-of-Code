input = *$<
rowidx = ->(l) { (0...l.size).filter { l[_1] =~ /^\.+$/ } }
cols = rowidx[input]
rows = rowidx[input.map(&:chars).transpose.map(&:join)]

w = input[0].size
pos = []
input.join.scan(/[#]/) { pos << [$`.size % w, $`.size / w] }
pos = pos.transpose.zip([rows, cols])

cdist = lambda { |(a, b), r, f|
    ex = r.count { _1 > a != _1 > b }
    (a - b).abs + f * ex
}
solve = ->(n) { pos.map { |(c, r, _)| c.combination(2).sum { cdist[_1, r, n] } }.sum }

puts "Part 1: #{solve[1]}"
puts "Part 2: #{solve[999999]}"
