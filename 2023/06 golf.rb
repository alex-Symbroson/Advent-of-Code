s=$<.readlines.map{_1.split[1..].map(&:to_i)}
c=->((t,d)){((t+(t*t-4*d)**0.5)/2).ceil-((t-(t*t-4*d)**0.5)/2).floor-1}
puts"Part1:#{s.reduce(&:zip).map(&c).reduce(&:*)}"
puts"Part2:#{c.call(s.map(&:join).map(&:to_i))}"

# alternative
c=->((t,d)){2*(t/2..).take_while{_1*(t-_1)>d}.size-(t.even?? 1:2)}
