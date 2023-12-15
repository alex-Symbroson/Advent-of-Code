input = $<.read.tr("\r\n", '').split(',')
hash = ->(l) { l.bytes.reduce(0) { (_1 + _2) * 17 % 256 } }

boxes = {}
input.map do |l|
    lbl, op = l.split(/[=-]/)
    box = boxes[1 + hash[lbl]] ||= []
    i = box.index { _1[0] == lbl } || box.size
    op ? box[i] = [lbl, op.to_i] : box.delete_at(i)
end

puts "Part 1: #{input.sum(&hash)}"
puts "Part 2: #{boxes.sum { |(i, b)| i * b.map.with_index.sum { |l, j| -~j * l[1] } }}"
