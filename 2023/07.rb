digx = -> { '0123456789TJQKA'.index(_1).to_s(16) }
sorter = ->((a, _, oa), (b, _, ob)) { oa == ob ? a <=> b : oa <=> ob }
winnings = -> { _1.sort(&sorter).map.with_index { |(_, b), i| b * (i + 1) }.sum }

order1 = lambda { |c|
    t = c.chars.tally.values.sort.reverse
    '11 21 22 31 32 41 5'.split.index(t[0, 2].join)
}

order2 = lambda { |c|
    perms = '23456789acde'.chars.repeated_combination(c.count('0'))
    perms.map { |p| order1.(p.reduce(c) { _1.sub('0', _2) }) }.max
}

cards = $<.map { [_1.split[0].chars.map(&digx).join, _1.split[1].to_i] }
cards1 = cards.map { _1 << order1.(_1[0]) }
puts "Part 1: #{winnings.(cards1)}"

cards.map! { |(a, b)| [a.gsub('b', '0'), b] }
cards2 = cards.map { _1 << order2.(_1[0]) }
puts "Part 2: #{winnings.(cards2)}"
