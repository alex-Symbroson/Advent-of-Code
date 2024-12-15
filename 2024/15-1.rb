map,ins = $<.read.split("\n\n").map{_1.split("\n")}
r,dirs = [],{'<'=> [-1,0], '>'=>[1,0], '^'=>[0,-1], 'v'=>[0,1]}
r[1] = map.index { |l| r[0] = l.index('@') }

m = ->((x, y), v = !1) { map[y][x] = v || map[y][x] }
step = ->((x,y), (a,b)) { [x + a, y + b] }

ins.join.chars.each{
    d,s,t = dirs[_1],r,' '
    t = m[s = step[s,d]] while !"#.".include?(t)
    next if t == '#'

    m[r,'.']
    r = step[r,d]
    m[s,'O'] if r != s
    m[r,'@']
}

part1 = map.each.with_index.sum{|l,y|
    l.chars.each.with_index.sum{|c,x|
        c=='O' ? y*100+x : 0
    }
}
puts "Part 1: #{part1}"
