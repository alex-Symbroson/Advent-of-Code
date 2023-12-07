input = ['', *$<]
parts = []
gears = {}

require './helper'

for i in 1...input.length
    input[i].gsub(/\d+/) do |m|
        range = $~.begin(0).clamp(1..) - 1..$~.end(0)
        # find parts in line i -1..1, return [match, y]
        part = input[i.clamp(0..) - 1..i + 1].map.with_index do |ln, y|
            [ln[range]&.match(/[^\d\n.]/), y + i - 1]
        end.find(&:[].(0))
        next unless part

        parts.push(m.to_i)
        key = "#{part[1]},#{part[0].begin(0) + range.begin}"
        gears[key] = gears.fetch(key, 1) * -m.to_i if part[0].match(0) == '*'
    end
end

print('Part 1: ', parts.sum, "\n")
print('Part 2: ', gears.values.filter(&:positive?).sum)
