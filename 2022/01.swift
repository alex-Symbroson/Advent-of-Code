import Foundation

let input = readinput(n: "input")
    .split(separator: "\n\n")
    .map 
    {
        $0
        .split(separator: "\n")
        .map { Int($0)! }
        .reduce(0, +)
    }

let res1 = input.max()!
print(res1)

let res2 = input
    .sorted()
    .suffix(_: 3)
    .reduce(0, +)
print(res2)
