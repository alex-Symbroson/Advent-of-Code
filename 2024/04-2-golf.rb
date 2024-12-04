i=*$<;h,w=i.length,i[0].length
c=->(x,y,a,b){"MAS".chars.all?{y>=0&&y<h&&i[y][x]==_1&&(x+=a;y+=b)}?1:0}
p (h*w).times.sum{|x|[-1,1].sum{|a|c[x%w-a,x/w-a,a,a]}*[-1,1].sum{|a|c[x%w-a,x/w+a,a,-a]}}
