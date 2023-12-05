require './helper'

input = File.read('input.txt')

seeds1 = input.match(/[\d ]+/).match(0).split.map(&:to_i)
seeds = []
seeds1.each_slice(2) { seeds << (_1.._1 + _2) }

maps = input.split("\n\n")[1..].map do |map|
    map.split("\n")[1..].map do
        e, s, l = _1.split.map(&:to_i)
        [s..s + l, e]
    end
end

def convSeedRange(seeds, i, maps)
    return [seeds] unless ms1 = maps[i]

    conv = ms1.find { seeds & _1[0] }
    return convSeedRange(seeds, i + 1, maps) unless conv

    delta = conv[1] - conv[0].begin
    new = seeds & conv[0]
    left = seeds.begin...new.begin if seeds.begin < new.begin
    right = seeds.end...new.end if seeds.end < new.end
    new = new.begin + delta..new.end + delta
    [new, left, right].compact.map { convSeedRange(_1, i + 1, maps) }.flatten
end

print('Part 1: ', seeds.map { convSeedRange(_1, 0, maps) }.flatten.map(&:begin).min)
