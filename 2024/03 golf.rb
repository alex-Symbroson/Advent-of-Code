i=$<.flat_map{_1.scan(/(do|don't)\(\)|mul\((\d+),(\d+)\)/)}
e,m=1,lambda{_1[1].to_i*_1[2].to_i}
p i.sum(&m),i.sum{|d|e=d[0]=="do"if d[0];e ?m[d]:0}
