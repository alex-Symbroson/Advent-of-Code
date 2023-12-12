# copied from u/4HbQ, translated to ruby
xs, ys = $<
         .map.with_index { |r, y| r.chars.map.with_index { |c, x| [x, y] if c == '#' } }
         .flatten(1).compact.transpose

dist = lambda { |ps, l|
    ps = ps.map { (0.._1).sum { |q| ps.include?(q) ? 1 : l } }
    ps.sum { |a| ps.sum { |b| (a - b).abs } } / 2
}

[2, 1_000_000].each { |l| puts [xs, ys].map { |r| dist.call(r, l) }.sum }
