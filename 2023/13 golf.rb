t=->(l,n){(1...(h=l.size)).sum{|k|l[i=k-1].zip(l[k]).count{_1!=_2}<=n&&(
(-[k,h-k].min+1..w=0).count{l[k-_1]!=l[i+_1]&&w=_1}==n&&
(n==0||l[i+w].zip(l[k-w]).count{_1!=_2}==1)&&k)||0}}
p *$<.read.tr(?\r,'').split("\n\n").map{m=_1.split(?\n).map(&:chars)
[0,1].map{|n|100*t[m,n]+t[m.transpose,n]}}.transpose.map(&:sum)