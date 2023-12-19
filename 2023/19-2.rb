rules = {}
parts = []
$<.read.strip.split("\n\n").then do |rulz, parz|
    rulz.lines.map do |r|
        name, *s = r.gsub(/([<>])/, '.\1.').split(/[{,}]\n?/);
        rules[name] = s.map { |c| c.split(/[.:]/) }
    end
    parts = parz.lines.map { eval(_1.tr('=', ':')) }
end

stack = []
stackA = []
stackR = []
makeRules = lambda { |r|
    return stackA << stack.map(&:clone).clone if r == 'A'
    return stackR << stack.map(&:clone).clone if r == 'R'

    for n, c, v, t in rules[r] do
        break makeRules[n] unless c

        stack << [n, c, v.to_i]
        makeRules[t]
        stack.pop
        stack << [n, { '<' => '>', '>' => '<' }[c], v.to_i]
    end
    stack.pop(rules[r].size - 1)
}
makeRules['in']

mergeRule = lambda { |r|
    r.group_by { _1.take(2) }.values.map do |rs|
        next rs.first if rs.size < 2
        next rs.max_by { _3 } if rs[0][1] == '>'
        next rs.min_by { _3 } if rs[0][1] == '<'

        p 'error'
    end.sort
}
stackA = stackA.map(&mergeRule) # .sort_by { |v| v.map { _3 } }
stackA = stackA.map { |r| r.group_by { _1[0] } }

test = lambda { |(_, c, v), a|
    # p([a, c, v, (c == '>' ? a > v : a < v)]);
    c == '>' ? a > v : a < v
}

allranges = []

dostuff = lambda { |first, last, stack1 = stackA, chars = 'amsx'.chars, ranges = []|
    if chars.empty?
        return 0 if stack1.empty?

        allranges << ranges
        prod = ranges.map { |a, b| b - a - 1 }.reduce(:*)
        # puts stack1.map { _1.values.flatten(1) }.map { _1.map(&:join).join(' && ') }.join("\n")
        # p [*ranges, stack1.size, prod]
        # puts [ranges.map { |(a, b)| a..b }].join(', ')
        # puts
        return prod
    end

    c = chars[0]
    # puts "\nA"
    as = stack1.flat_map { |r| r[c] ? r[c].map { _1[2] } : [] }.uniq.sort
    # puts stack1.map { _1.values.flatten(1) }.map { _1.map(&:join).join(' && ') }.join("\n")
    ([first] + as + [last]).each_cons(2).sum do |aa, ab|
        # puts "\nA"
        stackM = stack1.filter { |rs| rs[c] ? rs[c].all? { |ra| test.(ra, aa + 1) } : true }
        dostuff.(first, last, stackM, chars.drop(1), ranges + [[aa, ab]])
    end
}

mergeRanges = lambda { |ranges, i|
    ranges1 = ranges.map { |l| l.clone.delete_if.with_index { _2 == i } }
    ranges.size.times do |j|
        break if j >= ranges.size

        k = ranges1.find_index.with_index { |r, o| o != j && r == ranges1[j] }
        next unless k

        r1, r2 = ranges[j][i], ranges[k][i]
        next unless r1[0] == r2[1] || r1[1] == r2[0]

        ranges[j][i] = [[r1[0], r2[0]].min, [r1[1], r2[1]].max]
        ranges.delete_at(k)
        ranges1.delete_at(k)
    end
}

p dostuff.(a, 4001 + b)

# 167065581009388
# 167409079868000

4.times { 4.times { mergeRanges.(allranges, _1); } }
puts allranges.map(&:inspect).join("\n")
              .gsub('[0,', '[1,').gsub(', 4001', ', 4000')
puts
