max = { 'r' => 12, 'g' => 13, 'b' => 14 }

def sumTurns(turns, &op)
    turns.reduce({}) do |sum, turn|
        sum.update(turn) { |_k, old, new| op.(old, new) }
    end
end

games = $<.map do |line|
    line.split(': ')[1].split('; ').map do |turn|
        turn.split(', ').to_h do |cubes|
            t = cubes.split
            [t[1][0], t[0].to_i]
        end
    end
end

print('Part 1: ', games.map.with_index do |turn, i|
    turn.any? { |t| t.any? { |k, v| v > max[k] } } ? 0 : i + 1
end.sum, "\n")

print('Part 2: ', games.map do |game|
    sumTurns(game) { |a, b| [a, b].max }.values.reduce(:*)
end.sum)
