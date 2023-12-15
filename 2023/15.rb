input = $<.read.tr("\r\n", '').split(',')
hash = ->(l) { l.bytes.reduce(0) { (_1 + _2) * 17 % 256 } }
puts "Part 1: #{input.sum(&hash)}"

boxes = Hash.new { _1[_2] = [] }
input.map do |l|
    lbl, op = l.split(/[=-]/)
    box = boxes[1 + hash[lbl]]
    if op
        if i = box.index { _1[0] == lbl }
            box[i][1] = op.to_i
        else
            box.push([lbl, op.to_i])
        end
    else
        box.delete_if { _1[0] == lbl }
    end
end

puts "Part 2: #{boxes.sum { |(i, b)| i * b.map.with_index.sum { |l, j| -~j * l[1] } }}"
