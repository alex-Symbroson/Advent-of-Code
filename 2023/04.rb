wins = $<.readlines.map { |l| l.split(/ \| |: /)[1, 2].map(&:split).reduce(&:&).size }
puts "Part 1: #{(wins - [0]).sum { 2**(_1 - 1) }}"

cnt = wins.map { 1 }
wins.each.with_index { |w, i| (i + 1..i + w).each { cnt[_1] += cnt[i] if cnt[_1] } }
puts "Part 2: #{cnt.sum}"
