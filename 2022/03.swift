import Foundation

let input: String = readinput(n: "input")

let parsed = input
    .split(separator: "\n")
    .map {
        [Int]($0.map { Int($0.asciiValue!-65) })
        .map { $0 > 31 ? $0 - 31 : $0 + 27 }
    }

let res1 = parsed.reduce(0, {
    $0 + Set($1.prefix($1.count/2))
        .intersection($1.suffix($1.count/2))
        .reduce(0, +)
})
print(res1)

let res2 = stride(from: 0, to: parsed.count, by: 3).reduce(0, {
    $0 + Set<Int>(parsed[$1+0])
        .intersection(parsed[$1+1])
        .intersection(parsed[$1+2])
        .reduce(0, +)
})
print(res2)
