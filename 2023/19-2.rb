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
        stack << [n, '<', v.to_i, +1] if c == '>' # n>v -> n<=v -> n<v+1
        stack << [n, '>', v.to_i, -1] if c == '<' # n<v -> n>=v -> n>v-1
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

test = lambda { |(_, c, v, d), a|
    # p([a, c, v, (c == '>' ? a > v : a < v)]);
    #r1 = (c == '>' ? a > v : a < v)
    #v += d || 0
    #p([a,_,c,v,d]) if r1 != (c == '>' ? a > v : a < v)
    c == '>' ? a > v : a < v
}

allranges = []

foo = ->(a,b,(_, c, v, d)) {
    return [a,b] # if !d
    p([a,b,c,v,d])
    # c == '>' ? [v+d,b] : [a,v+d]
    res = [a,b]
    res = [v+d,b] if c == '>' && v == a
    res = [a,b+d] if c == '<' && v == b
    p(["--", [a,b], res]) if [a,b] != res
    res
}

dostuff = lambda { |first=0, last=4001, stack1 = stackA, chars = 'amsx'.chars, ranges = []|
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
    as = stack1.flat_map { |r| r[c] ? r[c].map { _1[2] } : [] }.uniq.sort {|a,b| (a - b).abs > 1 ? a-b : b-a}
    as if !as.empty?
    # puts stack1.map { _1.values.flatten(1) }.map { _1.map(&:join).join(' && ') }.join("\n")
    ([first] + as + [last]).each_cons(2).sum do |aa, ab|
        next 0 if aa > ab
        # puts "\nA"
        stackM = stack1.filter { |rs| rs[c] ? rs[c].all? { |ra| test.(ra, (aa,ab=foo[aa,ab,ra]).sum/2) } : true }
        dostuff.(first, last, stackM, chars.drop(1), ranges + [[aa, ab]])
    end
}

calc = ->(arr) { arr.sum{_1.map { |a, b| b - a - 1 }.reduce(:*)}}

# 167065581009388
# 167321718957000
# 167409079868000
p dostuff.()

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

p calc[allranges]
4.times { 4.times { mergeRanges.(allranges, _1); } }
puts allranges.map{|a,m,s,x|[x,m,a,s].map{|(g,h)|[g+1,h-1]}}.map(&:inspect).join("\n")
              # .gsub('[0,', '[1,').gsub(', 4001', ', 4000')
puts

p calc[allranges]


#[[1, 4000], [1, 838], [1, 1716], [1351, 2770]]
#[[1, 4000], [1, 838], [1, 1716], [1351, 2770]],

#[[1, 4000], [1, 4000], [1, 4000], [2770, 4000]]
#[[1, 4000], [1, 4000], [1, 4000], [2771, 4000]],

#[[1, 1416], [1, 4000], [1, 2006], [1, 1351]]
#[[1, 1415], [1, 4000], [1, 2005], [1, 1350]],

#[[2662, 4000], [1, 4000], [1, 2006], [1, 1351]]
#[[2663, 4000], [1, 4000], [1, 2005], [1, 1350]],

#[[1, 4000], [838, 1801], [1, 4000], [1351, 2770]]
#[[1, 4000], [839, 1800], [1, 4000], [1351, 2770]],

#[[1, 2440], [1, 2090], [2006, 4000], [537, 1351]]
#[[1, 2440], [1, 2090], [2006, 4000], [537, 1350]],

#[[1, 4000], [2090, 4000], [2006, 4000], [1, 1351]]
#[[1, 4000], [2091, 4000], [2006, 4000], [1, 1350]],
