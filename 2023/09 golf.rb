d=->(v){e=v.each_cons(2).map{_2-_1};v.last+(e.empty?? 0:d.(e))}
s=$<.map{_1.split.map(&:to_i)};p *[s,s.map(&:reverse)].map{_1.map(&d).sum}
