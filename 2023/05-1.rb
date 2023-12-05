input = File.read('input.txt')

seeds = input.match(/[\d ]+/).match(0).split.map(&:to_i)

maps = input.split("\n\n")[1..].map do |map|
    map.split("\n")[1..].map do
        _1.split.map(&:to_i)
        # [a..a + l, b..b + l]
    end
end

conv = seeds.map do |seed|
    maps.reduce(seed) do |s1, ms1|
        ms1.reduce(s1) { |s, ms| s == s1 && s >= ms[1] && s < ms[1] + ms[2] ? s - ms[1] + ms[0] : s }
    end
end

print('Part 1: ', conv.min)
