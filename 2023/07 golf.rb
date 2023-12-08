m=->(c,a=c){c.chars.tally.sum{_1[1]**2}.chr+a};
d,e=$<.map{_1.tr('TKA','BRS').split}.transpose;
[d.map(&m),d.map{|c|c.tr!('J',o='0');c.chars.repeated_combination(c.count(o))
.map{|p|m[p.reduce(c){_1.sub(o,_2)},c]}.max}]
.map{|c|p c.zip(e).sort.map.with_index.sum{_1[1].to_i*(_2+1)}}

# 4x70
# m=->(c,a=c){c.chars.tally.sum{_1[1]**2}.chr+a};d,e=$<.map{_1.tr('TKA',
# 'BRS').split}.transpose;[d.map(&m),d.map{|c|c.tr!('J',o='0');c.chars.
# repeated_combination(c.count(o)).map{|p|m[p.reduce(c){_1.sub(o,_2)},c
# ]}.max}].map{|c|p c.zip(e).sort.map.with_index.sum{_1[1].to_i*(_2+1)}}
