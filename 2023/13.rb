test = lambda { |l, nudge|
    for i in 0...l.size - 1
        next unless l[i].zip(l[i + 1]).count { _1 != _2 } <= nudge

        my = [0, 2 * i + 2 - l.size].max
        m2 = l[my..i].reverse.zip(l[i + 1..i + i + 1]).map { _1 == _2 }
        next unless m2.count(&:!) == nudge
        return i + 1 if nudge == 0

        j = m2.find_index(&:!)
        return i + 1 if l[i - j].zip(l[i + j + 1]).count { _1 != _2 } == 1
    end
    0
}

res = $<.read.tr("\r", '').split("\n\n").sum do |l|
    m = l.split("\n").map(&:chars)
    (
        100 * test[m, 0] + test[m.transpose, 0] +
        100i * test[m, 1] + 1i * test[m.transpose, 1])
end
puts "Part 1: #{res.real}"
puts "Part 2: #{res.imag}"
