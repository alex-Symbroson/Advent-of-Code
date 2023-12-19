rules = {}
parts = []
$<.read.strip.split("\n\n").then do |rulz, parz|
    rulz.lines.map do |r|
        name, *s = r.gsub(/([<>])/, '.\1.').split(/[{,}]\n?/);
        rules[name] = s.map { |c| c.split(/[.:]/) }
    end
    parts = parz.lines.map { eval(_1.tr('=', ':')) }
end

apply = lambda { |r, p = nil|
    return p if r == 'A'
    return nil if r == 'R'

    for n, c, v, t in rules[r] do
        return apply[n, p] unless c
        return apply[t, p] if c == '>' && p[n.to_sym] > v.to_i
        return apply[t, p] if c == '<' && p[n.to_sym] < v.to_i
    end
    p 'error', rules[r]
}

puts "Part 1: #{parts.filter_map { apply['in', _1]&.values }.flatten.sum}"
