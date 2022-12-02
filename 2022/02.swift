import Foundation

let input: String = readinput(n: "input")
let parsed = input
    .split(separator: "\n")
    .map {
        (Int($0.first!.asciiValue!-65),
        Int($0.last!.asciiValue!-88))
    }

let score1 = parsed
    .reduce(0, {
        let p = ($1.0 + $1.1 + 2) % 3 // own move
        return $0 + 3*$1.1 + p+1
    })
print(score1)

let score2 = parsed
    .reduce(0, {
        let w = ($1.1 - $1.0 + 4) % 3 // 0:loss, 1:draw, 2:win
        return $0 + 3*w + $1.1+1
    })
print(score2)
