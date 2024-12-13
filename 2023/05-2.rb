require './helper'

seeds, *maps = $<.read.split("\n\n")
seeds = seeds.split[1..].map(&:to_i).each_slice(2).map { _1.._1 + _2 }
$maps = maps.map { |m| m.split.map(&:to_i)[2..].each_slice(3).map { [_2.._2 + _3, _1 - _2] } }

def convSeeds(seeds, i)
    return [seeds] unless $maps[i]

    conv = $maps[i].find { seeds.intersect?(_1[0]) }
    newseeds = conv ? [(seeds & conv[0]) + conv[1], *seeds.split(conv[0])] : [seeds]
    newseeds.flat_map { convSeeds(_1, i + 1) }
end

puts "Part 2: #{seeds.map { convSeeds(_1, 0) }.flatten.map(&:begin).min}"
