m, comps = {}, Set[]

$<.each {
    a, b = _1.strip.split("-")
    comps += [a,b]
    (m[a] ||= Set[]) << b
    (m[b] ||= Set[]) << a
}

res = []
comps.filter { _1 =~ /^t/ }.each { |k|
    m[k].each { |k2|
        k2 != k && m[k2].each { |k3|
            res << Set[k, k2, k3] if m[k3] === k
        }
    }
}
puts "Part 1: #{res.uniq.length}"

nets = comps.map { Set[_1] }
nets.each { |n|
    comps.each { |c|
        n << c if n.all? { m[c] === _1 }
    }
}

puts "Part 2: #{nets.max_by(&:size).sort.join(',')}"
