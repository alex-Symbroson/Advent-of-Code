i=*$<;h,w=i.length,i[0].length
c=->(x,y,a,b){"XMAS".chars.all?{y>=0&&y<h&&i[y][x]==_1&&(x+=a;y+=b)}?1:0}
p (h*w*9).times.sum{|i|c[i%h,i/h%w,i/h/w%3-1,i/h/w/3-1]}
