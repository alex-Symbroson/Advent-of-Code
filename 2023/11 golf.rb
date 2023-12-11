i=*$<;r=->(l){(0...l.size).filter{l[_1]=~/^\.+$/}}
w=i[0].size;p=[];i.join.scan(/[#]/){p<<[$`.size% w,$`.size/w]}
v=->(f){p.transpose.zip([r[i.map(&:chars).transpose.map(&:join)],r[i]])
.map{|(c,r,_)|c.combination(2).sum{|(a,b)|(a-b).abs+f*r.count{_1>a!=_1>b}}}.sum}
p v[1],v[999999]
