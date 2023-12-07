digits = $<.map { |line| line.scan(/\d/) }
print('Part 1: ', digits.sum { |num| (num.first + num.last).to_i }, "\n")

names = %w[_ one two three four five six seven eight nine]
digits = $<.map do |line|
    line.gsub(Regexp.new("(?=(#{names.join('|')}))")) do |_|
        names.index($1).to_s
    end.scan(/\d/)
end

print('Part 2: ', digits.sum { |num| (num.first + num.last).to_i })
