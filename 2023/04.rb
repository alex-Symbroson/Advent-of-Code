input = File.readlines('input.txt')

wins = input.map { |l| l.split(/ \| |: /)[1, 2].map { _1.split.map(&:to_i) }.reduce(&:&).size }
puts "Part 1: #{wins.map { _1 > 0 ? 2.pow(_1 - 1) : 0 }.sum}"

cnt = wins.map { 1 }
wins.each.with_index { |w, i| (i + 1..i + w).each { cnt[_1] += cnt[i] if cnt[_1] } }
puts "Part 2: #{cnt.sum}"
