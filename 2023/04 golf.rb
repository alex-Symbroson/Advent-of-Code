w=$<.map{_,b,c=_1.split(/:|\|/);(b.split&c.split).size}
puts"Part1:#{(w-[0]).sum{2**(_1-1)}}"
c=w.map{1};w.each.with_index{|v,i|(i+1..i+v).each{c[_1]+=c[i]}}
puts"Part2:#{c.sum}"