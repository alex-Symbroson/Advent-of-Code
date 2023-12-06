s = $<.readlines
m = s.map { |l| l.split[1..].map(&:to_i) }
l = m[0].zip(m[1])
r = l.map { |(t, d)| (0..t).map { _1 * (t - _1) }.filter { _1 > d } }.map(&:length)
puts "Part 1: #{r.reduce(&:*)}"

m = s.map { |l| l.gsub(' ', '').split(':')[1].to_i }
l = [m]
r = l.map { |(t, d)| (t / 4..3 * t / 4).map { _1 * (t - _1) }.filter { _1 > d } }.map(&:length)
puts "Part 2: #{r.reduce(&:*)}"
