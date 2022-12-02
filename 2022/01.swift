import Foundation

let input: String = readinput(n: "input")
let parsed = input
    .split(separator: "\n\n")
    .map 
    {
        $0
        .split(separator: "\n")
        .map { Int($0)! }
        .reduce(0, +)
    }

let res1 = parsed.max()!
print(res1)

let res2 = parsed
    .sorted()
    .suffix(_: 3)
    .reduce(0, +)
print(res2)
