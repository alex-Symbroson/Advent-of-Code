
import Foundation

let input: String = readinput(n: "input")
var parsed = input.split(separator: "\n")
    .map { $0.split(separator: " ") }

var (reg, cycle, sum) = (1, 0, 0)
var crt = Array(repeating: " ", count: 40)

for op in parsed
{
    addcycle()
    if op[0] == "addx" {
        addcycle();
        reg += Int(op[1])!;
    }
}
print(sum)

func addcycle()
{
    crt[cycle % 40] = abs(cycle % 40 - reg) < 2 ? "#" : " "
    cycle += 1
    if cycle % 40 == 20 { sum += cycle * reg }
    if cycle % 40 == 0 { print(crt.joined(separator: "")); }
}