input = $<.read.split("\n\n").map { _1.split("\n").map(&:chars).transpose }

arr = [[], []]
input.each { |k|
    t = k[0][0] == '#' ? 1 : 0
    arr[t] << k.map { _1.count('.#'[t]) }
}

part1 = arr[1].sum { |key|
    arr[0].count { |lock|
        key.each_with_index.all? { |v, i| v <= lock[i] }
    }
}
puts "Part 1: #{part1}"
