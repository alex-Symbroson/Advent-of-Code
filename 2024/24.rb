
map = {}
$<.read.each_line{
    m = _1.scan(/\w+/)
    map[m[0]] = [m[1].to_i] if m.length == 2
    map[m[3]] = m[..2] if m.length == 4
}

#sw = "z07,bjm,hsw,z13,skf,z18"
#sw.split(",").each_cons(2) { |a,b| map[a],map[b] = map[b],map[a] }

op = {AND: :&, OR: :|, XOR: :^}
xs, ys, zs = "xyz".chars.map { |c|
    map.keys.select { _1.start_with?(c) }.sort
}

ops = ""
calc = ->(v, r=0) {
    expr = map[v]
    isv = expr.length == 1

    sop = isv ? v : "(#{expr.join(' ')})"
    ops = r==0 ? v + ' = ' + sop : ops.sub(v, sop) if r < 3

    next expr[0] if isv
    next 0 if r > 50
    a, b, c = calc[expr[0], r+1], expr[1].to_sym, calc[expr[2], r+1]
    a.send(op[b], c)
}

run = ->(n = 50) {
    zs.sort.map.with_index.sum { |v, i|
        i <= n ? calc[v] * 2**i : 0
    }
}

puts "Part 1: #{run[]}"

swaps = []
(xs+ys).each{map[_1] = [0]}

xs[2..].each { |xkey|
    i = xkey[1..].to_i
    map["x%02d" % -~i] = [0]
    map[xkey] = [1]
    run[i]
    cnt = op.keys.map { ops.scan(/(?= #{_1} )/).size }
    next if cnt == [2, 1, 2]

    l = [xkey.tr(?x, ?z)]
    2.times { l += l.flat_map{map[_1]} }
    l.filter! { map[_1] && _1[0]!='x' && _1[0]!='y' }
    swaps += [l.uniq]
}

xs.each{map[_1] = [0]}

valid = []
check = ->() {
    p ["te", valid]
    xs.all? {|xkey|
        map[xkey] = [1]

        r = run[]
        n = 1 << xkey[1..].to_i
        p ["cf", valid, xkey, r,  n] if r != n
        p xs.map{map[_1]}.join if r != n
        p ys.map{map[_1]}.join if r != n
        p (ys.map{"0"}.join + r.to_s(2))[-ys.size..].reverse! if r != n

        map[xkey] = [0]
        r == n
    }
}

swap_res = []
p swap_combos = (swaps.size/2).times.map { [swaps[_1*2], swaps[_1*2+1]] }
findvalid = ->(i = 0) {
    break (swap_res << valid.dup if check[]) unless swap_combos[i]
    la, lb = swap_combos[i]
    next if la[0] == lb[0]

    e = la[0]
    va = e[1..].to_i
    xkey = "x" + e[1..]
    map[xkey] = [1]

    la.each { |a| lb.each { |b|
        next if b[0] == 'z'

        map[a], map[b] = map[b], map[a]
        begin
            next if (1 << va) != run[va+1]

            valid << [a, b]
            map[xkey] = [0]
            findvalid[i + 1]
            map[xkey] = [1]
            valid.pop
        end
        map[a], map[b] = map[b], map[a]
    } }
    map[xkey] = [0]
}

findvalid[]

p swap_res

# z07,bjm, hsw,z13, skf,z18 wkr,nvr
