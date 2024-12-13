max = { 'r' => 12, 'g' => 13, 'b' => 14 }

def sumTurns(turns, &op)
    turns.reduce({}) { |sum, turn|
        sum.update(turn) { |_k, old, new| op.(old, new) }
    }
end

games = $<.map { |line|
    line.split(': ')[1].split('; ').map { |turn|
        turn.split(', ').to_h { |cubes|
            t = cubes.split
            [t[1][0], t[0].to_i]
        }
    }
}

puts "Part 1: #{games.map.with_index.sum { |turn, i|
    turn.any? { |t| t.any? { |k, v| v > max[k] } } ? 0 : i + 1
}}"

puts "Part 2: #{games.map.sum { |game|
    sumTurns(game) { |a, b| [a, b].max }.values.reduce(:*)
}}"
