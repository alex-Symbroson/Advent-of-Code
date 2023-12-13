test = lambda { |l|
    for i in 0...l.size - 1
        next unless l[i] == l[i + 1]

        return i + 1 if l[..i].reverse.zip(l[i + 1..]).all? { !_1 || !_2 || _1 == _2 }
    end
    0
}

res = $<.read.split(/\r?\n\r?\n/).sum do |l|
    m = l.split(/\r?\n/).map(&:chars)
    a = test[m]
    b = test[m.transpose]
    100 * a + b
end
puts "Part 1: #{res}"
