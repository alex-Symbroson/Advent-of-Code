input = File.readlines('input.txt')
wins = input.map do |l|
    nums = l[l.index(': ') + 2..].split(' | ').map { |r| r.split.map(&:to_i) }
    nums[1].filter { |n| nums[0].index(n) }.length
end

sum1 = wins.map { |w| w > 0 ? 2.pow(w - 1) : 0 }.sum
print('Part 1: ', sum1, "\n")

counts = wins.map { |_| 1 }
wins.map.with_index do |w, i|
    for c in i + 1..i + w do
        counts[c] += counts[i] if wins[c]
    end
end
print('Part 2: ', counts.sum)
