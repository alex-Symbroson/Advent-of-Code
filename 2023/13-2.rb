test = lambda { |l, skip2 = false|
    for i in 0...l.size - 1
        next unless l[i].zip(l[i + 1]).count { _1 != _2 } < (skip2 ? 1 : 2)

        my = [0, 2 * i + 2 - l.size].max
        m = l[my..i] + l[i + 1..i + i + 1]
        m2 = m.reverse.zip(m).map { _1 == _2 }

        next if skip2
        next unless m2.count(&:!) == 2

        j = my + m2.find_index(&:!)
        j2 = 2 * i - j + 1
        x = l[j].zip(l[j2]).count { _1 != _2 }
        next if x > 1

        return i + 1
    end
    0
}

res = $<.read.split(/\r?\n\r?\n/).sum do |l|
    m = l.split(/\r?\n/).map(&:chars)
    a = test[m]
    b = test[m.transpose]
    100 * a + b
end
puts "Part 2: #{res}"
