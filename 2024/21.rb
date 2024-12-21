
input = $<.map(&:strip)
numpad = "A0 321654987"
dirpad = "A^ >v<"

todir = ->(x1,y1,x2,y2) {
    x,y = x2-x1, y2-y1
    xs, ys = x>0?"<"*x:">"*-x, y>0?"^"*y:"v"*-y
    next [ys+xs] if y1==0 && x2==2
    next [xs+ys] if y2==0 && x1==2
    x>0 ? [xs+ys, ys+xs] : [ys+xs, xs+ys]
}

seq = ->(s, t, pad) {
    ti, si = pad.index(t), pad.index(s)
    res = todir[si%3, si/3, ti%3, ti/3].uniq.min_by{_1.squeeze.size}
    pad == numpad ? res : res.tr("v^","^v")
}

cache = {}
solve = ->(num, n, pad) {
    next num.size if n < 0
    cache[num+n.to_s] ||= ("A"+num).chars.each_cons(2)
        .map{solve[seq[_1, _2, pad]+"A", n-1, dirpad]}.sum
}

part1 = input.sum{ solve[_1, 2, numpad] * _1[..2].to_i }
puts "Part 1: #{part1}"

part2 = input.sum { solve[_1, 25, numpad] * _1[..2].to_i }
puts "Part 2: #{part2}"
