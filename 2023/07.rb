digx = -> { '0123456789TJQKA'.index(_1).to_s(16) }
sorter = ->(a, b) { a[0].to_s + a[1] <=> b[0].to_s + b[1] }

order1 = ->(c) { c.chars.tally.values.sum { _1**2 }.chr }
order2 = lambda { |c|
    perms = c.chars.repeated_combination(c.count('0'))
    perms.map { |p| order1.(p.reduce(c) { _1.sub('0', _2) }) }.max
}

cards, bids = $<.map { [_1.split[0].gsub(/./, &digx), _1.split[1].to_i] }.transpose
winnings = ->(c) { c.zip(cards, bids).sort(&sorter).map.with_index.sum { _1[2] * (_2 + 1) } }
puts "Part 1: #{winnings.(cards.map(&order1))}"

cards.map { _1.gsub!('b', '0') }
puts "Part 2: #{winnings.(cards.map(&order2))}"
