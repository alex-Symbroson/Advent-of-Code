s = $<.readlines
m = s.map { |l| l.split[1..].map(&:to_i) }.reduce(&:zip)
r = m.map { |(t, d)| (t / 2..).take_while { _1 * (t - _1) > d }.size }
puts "Part 1: #{r.map { (_1 * 2) - 1 }.reduce(&:*)}"

t, d = s.map { |l| l.gsub(' ', '').split(':')[1].to_i }
r = (t / 2..).take_while { _1 * (t - _1) > d }.size
puts "Part 2: #{(2 * r) - 1}" # even time so -1
