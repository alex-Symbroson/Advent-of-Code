import heapq

HALL_CELLS = [15, 16, 18, 20, 22, 24, 25]
STACKS = [
    [69, 57, 45, 31],
    [71, 59, 47, 33],
    [73, 61, 49, 35],
    [75, 63, 51, 37]
]
HALL_ENTRANCES = [17, 19, 21, 23]
WEIGHTS = {'A': 1, 'B': 10, 'C': 100, 'D': 1000}

def move_home(map):
    # Try to move from hallway home for all cells, may need to repeat
    for stack_i, stack in enumerate(STACKS):
        empty_space = None
        stack_ch = 'ABCD'[stack_i]
        distance_in = 4
        for cell in stack:
            if map[cell] == '.':
                empty_space = cell
                break
            if map[cell] != stack_ch:
                break
            distance_in -= 1
        if not empty_space:
            continue

        hall_entrance = HALL_ENTRANCES[stack_i]
        for cell in HALL_CELLS:
            if all((cell2 == cell and map[cell2] == stack_ch) or (cell2 != cell and map[cell2] == '.')
                    for cell2 in range(min(cell, hall_entrance), max(cell, hall_entrance) + 1)):
                # Move home!
                distance = (abs(cell - hall_entrance) + distance_in) * WEIGHTS[stack_ch]
                new_map = map[0:cell] + '.' + map[cell + 1:]
                new_map = new_map[0:empty_space] + stack_ch + new_map[empty_space + 1:]
                return distance, new_map
    return 0, map


def transitions(map):
    res = []

    stack_tops = []
    distances_out = []

    for stack in STACKS:
        stack_top = None
        distance_out = 5
        for cell in stack:
            if map[cell] == '.':
                break
            stack_top = cell
            distance_out -= 1
        stack_tops.append(stack_top)
        distances_out.append(distance_out)

    # Each stack top can move to an unblocked hallway
    for stack_i in range(4):
        if not stack_tops[stack_i]:
            continue
        hall_entrance = HALL_ENTRANCES[stack_i]
        for cell in HALL_CELLS:
            if all(map[cell2] == '.'
                   for cell2 in range(min(cell, hall_entrance), max(cell, hall_entrance) + 1)):
                # Possible transition
                ch = map[stack_tops[stack_i]]
                new_map = map[0:cell] + ch + map[cell + 1:]
                new_map = new_map[0:stack_tops[stack_i]] + '.' + new_map[stack_tops[stack_i] + 1:]
                distance = (distances_out[stack_i] + abs(cell - hall_entrance)) * WEIGHTS[ch]
                # print(new_map)
                while (True):
                    distance2, new_map = move_home(new_map)
                    distance += distance2
                    if distance2 == 0:
                        break
                res.append((distance, new_map))
        #break
    return res

def is_win(map):
    # Only checks the top of the stacks so will fail on some inputs
    for stack_i, stack in enumerate(STACKS):
        if map[stack[3]] != 'ABCD'[stack_i]:
            return False
    return True

def main():
    lines = open('23.txt').readlines()
    insert = ['  #D#C#B#A#\n', '  #D#B#A#C#\n']
    start_map = ''.join(lines[0:3] + insert + lines[3:])
    visited = set()
    heap = [(0, start_map)]
    heapq.heapify(heap)

    while(heap):
        total_dist, map = heapq.heappop(heap)
        if is_win(map):
            print(f'Part 2 Answer: {total_dist}')
            break
        # print(total_dist)
        if map in visited:
            continue
        visited.add(map)
        for dist, new_map in transitions(map):
            heapq.heappush(heap, (total_dist + dist, new_map))

main()