dir = ->(d) { (1 - d) * (~d % 2) + 1i * (2 - d) * (d % 2) }

input = $<.read.strip.split("\n").map do |l|
    r, d, l = l.match(/^(.) (\d+) \(#(.+)\)$/).captures
    ['RDLU'.index(r), d.to_i, l.to_i(16)]
end

calc_area = lambda { |inp|
    p = 0
    area = 0
    inp.map do |d, n, _|
        q = p + n * dir[d];
        area += p.real * q.imag - p.imag * q.real + n
        p = q
    end
    return area / 2 + 1
}

puts "Part 1: #{calc_area[input]}"
puts "Part 2: #{calc_area[input.map { [_3 % 4, _3 >> 4] }]}"
