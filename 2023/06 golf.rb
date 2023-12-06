# alternative: math
c=->((t,d)){((t+(t*t-4*d)**0.5)/2).ceil-((t-(t*t-4*d)**0.5)/2).floor-1}
# alternative: brute force
c=->((t,d)){2*(t/2..).take_while{_1*(t-_1)>d}.size-(t.even?? 1:2)}
# alternative: fixup binary search
c=->((t, d)){b=t/2-(0...t/2).bsearch{_1*(t-_1)>d};2*b+1+t%2}
# alternative: fixup math
c=->((t, d)){b=((t*t-4*d-4)**0.5).to_i;b+(t+b+1)%2}

s=$<.readlines.map{_1.split[1..].map(&:to_i)}
puts"Part1:#{s.reduce(&:zip).map(&c).reduce(&:*)}"
puts"Part2:#{c.call(s.map(&:join).map(&:to_i))}"
