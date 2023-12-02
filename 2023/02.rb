input = File.readlines('input.txt')

def sumTurns(turns, &op)
    turns.reduce({}) do |sum, turn|
        sum.update(turn) { |_k, old, new| op.call(old, new) }
    end
end

games = input.map do |line|
    line.split(': ')[1].split('; ').map do |turn|
        sumTurns(
            turn.split(', ').map do |cubes|
                t = cubes.split
                [[t[1][0], t[0].to_i]].to_h
            end
        ) { |a, b| a + b }
    end
end

max = { 'r' => 12, 'g' => 13, 'b' => 14 }

print('Part 1: ', games.map.with_index do |turn, i|
    turn.any? { |t| t.any? { |k, v| v > max[k] } } ? 0 : i + 1
end.sum, "\n")

print('Part 2: ', games.map do |game|
    sumTurns(game) { |a, b| [a, b].max }.values.reduce(:*)
end.sum)
