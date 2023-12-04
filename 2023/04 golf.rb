w=File.readlines('input.txt').map{|l|l.split(/:|\|/)[1,2].
map{_1.split.map(&:to_i)}.reduce(&:&).size}
puts"Part1:#{(w-[0]).map{2.pow(_1-1)}.sum}"
c=w.map{1};w.each.with_index{|v,i|(i+1..i+v).each{c[_1]+=c[i]}}
puts"Part2:#{c.sum}"