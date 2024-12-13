list = $<.read.split("\n\n").map{_1.scan(/\d+/).map(&:to_f)}

calc = ->((ax,ay,bx,by,cx,cy)) {
    # a*ax + b*bx = cx
    # a*ay + b*by = cy

    # a*ax*ay + b*bx*ay = cx*ay       |  I*ay
    # a*ax*ay + b*by*ax = cy*ax       | II*ax
    # b*bx*ay - b*by*ax = cx*ay-cy*ax | I-II
    b = (cx*ay-cy*ax) / (bx*ay-by*ax)
    a = (cx-b*bx)/ax

    c = 3*a+b
    a%1==0 && b%1==0 ? c.to_i : 0
}

puts "Part 1: #{list.sum(&calc)}"
list.each { _1[4]+=1e13; _1[5]+=1e13 }
puts "Part 2: #{list.sum(&calc)}"
