reg, prog = $<.read.split("\n\n").map{_1.scan(/\d+/).map(&:to_i)}
ip, out = 0, []

opr = ->(op) { op<4 ? op : reg[op-4] }
ops = {
    0 => ->(op) { reg[0] >>= opr[op] },
    1 => ->(op) { reg[1] ^= op },
    2 => ->(op) { reg[1] = opr[op]&7 },
    3 => ->(op) { ip = op-2 if reg[0]>0 },
    4 => ->(op) { reg[1] ^= reg[2] },
    5 => ->(op) { out << (opr[op]&7) },
    6 => ->(op) { reg[1] = reg[0] >> opr[op] },
    7 => ->(op) { reg[2] = reg[0] >> opr[op] },
}

run = ->(creg) {
    ip, out, *reg = 0, [], *creg
    while ip < prog.size do
        op,co = prog[ip],prog[ip+1]
        ops[op][co]
        ip += 2
    end
    out
}

puts "Part 1: #{run[reg].join(',')}"

# 8 bit triplet combinations to output any instruction
triplets = Hash.new([])
(8**3).times { |a|
    pi = run[[a,0,0]].first
    triplets[pi] += [[a%8, a/8%8, a/64]]
}

# combine triplets to continuous 8 bit number digits
check = ->(f, opts, i = opts.size-1) {
    next [[]] if i<0
    opts[i].filter_map{|l|
        next [] if l[1]!=f[0] || l[2]!=f[1]
        check[l, opts, i-1].each{_1 << l}
    }.flatten!(1)
}

opts = prog.map{triplets[_1]}
sols = check[[0,0,0], opts]

part2 = sols.map { |digs|
    # p digs.map(&:first).join # octal value

    # decimal conversion
    rega = p digs.each.with_index.sum{|v,i| v[0]*8**i}
    p run[[rega, 0, 0]]

    p digs.map{|a1,a2,a3| # run program
        a = a1 + a2*8 + a3*64
        (a1^(a>>(a1^5))^3)%8
    }

    p run[[rega, 0, 0]] == prog

    rega
}.min

puts "Part 2: #{part2}"
