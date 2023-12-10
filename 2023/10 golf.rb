b=(l=*$<)[0].size;v=[];p=(l.join=~/S/)
m=->((x,y),v=!1){l[y][x]=v||l[y][x]}
s=->((x,y),d){[x+(~d+2)*(~d%2),y+(2-d)*(d%2)]}
t=->(a,d){[a=s[a,d],(d+3+%w[J-7 L|J F-L 7|F][d].index(m[a]))%4]rescue !1}
f=->(a){m[a]=~/[\*\#S]/?0:[m[a,?#],(0..3).map{f[s[a,_1]]}]}
w=->{v<<_1 if m[_1]!=?*}
a,d=(0..3).filter_map{t[[p%b,p/b],_1]}[0]
p (2..).find{m[a,?*]
next 1 unless n=t[a,d]
w[s[a,e= ~-d%4]];w[s[n[0],e]]
!(a,d=n)}/2
v.map(&f)
p l.join.count(?#)