seeds, *maps = $<.read.split("\n\n")
seeds = seeds.split[1..].map(&:to_i)
maps = maps.map { _1.split.map(&:to_i)[2..] }

conv = seeds.map do |seed|
    maps.reduce(seed) do |s, ms1|
        msf = ms1.each_slice(3).find { |(_, a, l)| s >= a && s < a + l }
        msf ? s - msf[1] + msf[0] : s
    end
end

print('Part 1: ', conv.min)
