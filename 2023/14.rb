m = $<.map(&:chars)
getload = -> { _1.map.with_index { |b, i| b.count('O') * -~i }.sum }
drop = -> { _1.gsub!(/(O+)(\.+)/, '\2\1') while _1.include?('O.'); _1 }
hist = []

loop do
    4.times do |i|
        m = m.reverse.transpose.map { drop[_1.join].chars }
        puts "Part1: #{getload[m.transpose]}" if hist.empty? && i == 0
    end

    hist << load = getload[m.reverse]
    si = hist[..-2].rindex(load)
    len = hist.size - 1
    next unless si && hist[si..-2] == hist[2 * si - len...si]

    len -= si
    puts "Part2: #{hist[si + (1_000_000_000 + ~si) % len]}"
    break
end
