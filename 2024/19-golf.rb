t,i=$<.read.split("\n\n").map{_1.split(/\n|, /)}
m,f={},->(q){m[q]||=q==""?1:t.sum{q.start_with?(_1)?f[q[_1.size..]]:0}}
p i.count{f[_1]>0},i.sum(&f)