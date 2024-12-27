
map = {}
$<.read.each_line{
    m = _1.scan(/\w+/)
    map[m[0]] = [m[1].to_i] if m.length == 2
    map[m[3]] = m[..2] if m.length == 4
}

#sw = "z07,bjm,hsw,z13,skf,z18"
#sw.split(",").each_cons(2) { |a,b| map[a],map[b] = map[b],map[a] }

op = {AND: :&, OR: :|, XOR: :^}

calc = ->(v, b=nil) {
    expr = map[v]
    next expr[0] if expr.length == 1
    a, b, c = calc[expr[0]], expr[1].to_sym, calc[expr[2]]
    a.send(op[b], c)
}

run = ->(n = 50) {
    map.keys.select { _1.start_with?('z') }.sort.map.with_index.sum { |v, i|
        i <= n ? calc[v, n] * 2**i : 0
    }
}

puts "Part 1: #{run[]}"
