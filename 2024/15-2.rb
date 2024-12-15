input = $<.read.gsub(/([#.])/,'\1\1').gsub('O','[]').gsub('@','@.')
r,dirs = [],{'<'=>[-1,0], '>'=>[1,0], '^'=>[0,-1], 'v'=>[0,1]}
map,ins = input.split("\n\n").map{_1.split("\n")}
r[1] = map.index { |l| r[0] = l.index('@') }

m = ->((x, y), v = !1) { map[y][x] = v || map[y][x] }
step = ->((x,y), (a,b)) { [x + a, y + b] }

pushh = ->(s,d,act=false) {
    t = m[s]
    next if t == '#'

    w = "[]]["[d[0]+1..]
    if t != '.' then
        s = step[step[s,d],d]
        next if !pushh[s,d,act]
        next true if !act
        m[step[s, [-d[0],0]], w[1]]
    end
    m[s, w[0]] if act
    true
}

pushv = ->(s,d,act=false) {
    t = m[s]
    next if t == '#'

    if i = "][".index(m[s]) then
        ts = [i, i-1].map { step[s, [_1,d[1]]] }
        next if !ts.all? { pushv[_1, d, act] }
        next true if !act

        m[[s[0]+i-1, s[1]], '.']
        m[[s[0]+i, s[1]], '.']

        m[ts[0], ']']
        m[ts[1], '[']
    end
    true
}

ins.join.chars.each{
    d = dirs[_1]
    s = step[r,d]

    next if d[1] == 0 && !(pushh[s,d] && pushh[s,d,true])
    next if d[0] == 0 && !(pushv[s,d] && pushv[s,d,true])

    m[r,'.']
    m[r = step[r,d],'@']
}

#print "\033[H;\033[H;"
#print map.join("\n")

part2 = map.each.with_index.sum{|l,y|
    l.chars.each.with_index.sum{|c,x|
        c=='[' ? y*100+x : 0
    }
}
puts "Part 2: #{part2}"
