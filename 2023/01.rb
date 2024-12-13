lines = *$<
calc = ->(l) { l=l.dup; l.gsub!(/\D/, ''); (l[0] + l[-1]).to_i }
puts "Part 1: #{lines.sum(&calc)}"

names = %w[_ one two three four five six seven eight nine]
print('Part 2: ', lines.sum { |line|
    calc[line.gsub(Regexp.new("(?=(#{names.join('|')}))")) {
        names.index($1).to_s
    }]
})
