order,list = $<.read.split("\n\n").map{|l|l.split("\n").map{_1.split(/\||,/).map(&:to_i)}}

ogt = order.group_by(&:first).transform_values { _1.map(&:last) }
olt = order.group_by(&:last).transform_values { _1.map(&:first) }

sol = list.reduce(Hash.new(0)) { |h, l|
    pl = l.sort { |a, b|
        ogt[a]&.include?(b) ? -1 :
        (olt[a]&.include?(b) ? 1 : 0)
    }
    h[l.zip(pl).all? { _1[0] == _1[1] }] += pl[pl.size/2]
    h
}

print('Part 1: ', sol[true], "\n")
print('Part 2: ', sol[false], "\n")
