s=$<.readlines
m=s.map{_1.split[1..].map(&:to_i)}.reduce(&:zip)
r=m.map{|(t,d)|(t/2..).take_while{_1*(t-_1)>d}.size*2-1}
puts"Part1:#{r.reduce(&:*)}"

t,d=s.map{_1.delete(' ').split(':')[1].to_i}
r=(t/2..).take_while{_1*(t-_1)>d}.size
puts"Part2:#{r*2-1}"

#short: (0..t).map{_1*(t-_1)}.filter{_1>d}.size
# fast: (t/2..).take_while{_1*(t-_1)>d}.size*2-1