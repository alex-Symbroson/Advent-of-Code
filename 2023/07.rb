digx = -> { '0123456789TJQKA'.index(_1).to_s(16) }

order1 = ->(c, a = c) { c.chars.tally.values.sum { _1**2 }.chr + a }
order2 = lambda { |c|
    perms = c.chars.repeated_combination(c.count('0'))
    perms.map { |p| order1.(p.reduce(c) { _1.sub('0', _2) }, '') }.max + c
}

cards, bids = $<.map { [_1.split[0].gsub(/./, &digx), _1.split[1].to_i] }.transpose
winnings = ->(c) { c.zip(bids).sort.map.with_index.sum { _1[1] * (_2 + 1) } }
puts "Part 1: #{winnings.(cards.map(&order1))}"

cards.map { _1.gsub!('b', '0') }
puts "Part 2: #{winnings.(cards.map(&order2))}"
