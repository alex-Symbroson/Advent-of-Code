m=->(c,a=c){c.chars.tally.values.sum{_1**2}.chr+a}
n=->(c){c.chars.repeated_combination(c.count('0')).map{|p|m.(p.reduce(c){_1.sub('0',_2)},c)}.max}
d,e=$<.map{|c|[c.split[0].gsub(/./){'0123456789TJQKA'.index(_1).to_s(16)},c.split[1].to_i]}.transpose
w=->(c){c.zip(d,e).sort.map.with_index.sum{_1[2]*(_2+1)}}
p w.(d.map(&m));d.map{_1.gsub!('b','0')};p w.(d.map(&n))