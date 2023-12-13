test = lambda { |l, nudge|
    for i in 0...l.size - 1
        k = i + 1
        next unless l[i].zip(l[k]).count { _1 != _2 } <= nudge

        m2 = (0...[k, l.size - k].min).filter { l[k + _1] != l[i - _1] }
        next unless m2.size == nudge

        nudged = m2[0] && l[i - m2[0]].zip(l[k + m2[0]]).count { _1 != _2 }
        return k if nudge == 0 || nudged == 1
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
