expand = ->(s) { s.gsub(/^([.+]+)$/) { _1.tr('.', '+') } }
input = $<.read
input2 = expand[input].lines.map(&:chars).transpose[..-2].map(&:join).join("\n") + "\n"
input = expand[input2].lines.map(&:chars).transpose[..-2].map(&:join).join("\n") + "\n"
horiz = input.lines[0]
vert = input2.lines[0]

w = -~(input =~ /\n/)
pos = []
input.scan(/[#]/) { pos << [$`.size % w, $`.size / w] }

cdist = lambda { |((a, b), (c, d))|
    ex = horiz[a < c ? a..c : c..a].count('+') + vert[b < d ? b..d : d..b].count('+')
    (a - c).abs + (b - d).abs + ($age - 1) * ex
}

$age = 2
puts "Part 1: #{pos.combination(2).map(&cdist).sum}"
$age = 1_000_000
puts "Part 2: #{pos.combination(2).map(&cdist).sum}"
