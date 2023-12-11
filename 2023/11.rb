input = *$<
rowidx = ->(l) { (0...l.size).filter { l[_1] =~ /^\.+$/ } }
cols = rowidx[input]
rows = rowidx[input.map(&:chars).transpose.map(&:join)]

w = input[0].size
pos = []
input.join.scan(/[#]/) { pos << [$`.size % w, $`.size / w] }

cdist = lambda { |((a, b), (c, d))|
    ex = rows.count { _1 > a != _1 > c }
    ex += cols.count { _1 > b != _1 > d }
    (a - c).abs + (b - d).abs + ~-$age * ex
}

$age = 2
puts "Part 1: #{pos.combination(2).map(&cdist).sum}"
$age = 1_000_000
puts "Part 2: #{pos.combination(2).map(&cdist).sum}"
