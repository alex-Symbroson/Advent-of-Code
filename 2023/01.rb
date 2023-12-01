input = File.readlines('input.txt')

digits = input.map { |line| line.chars.filter { |c| c >= '0' && c <= '9' } }
print('Part 1: ', digits.sum { |num| (num.first + num.last).to_i }, "\n")

names = %w[zedddddro one two three four five six seven eight nine]
digits = input.map do |line|
    names
        .filter { |n| line.include?(n) }
        .reduce(line) { |l, r| l.gsub(r, r + names.index(r).to_s + r) }
        .chars.filter { |c| c >= '0' && c <= '9' }
end
print('Part 2: ', digits.sum { |num| (num.first + num.last).to_i })
