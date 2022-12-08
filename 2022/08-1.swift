
import Foundation

let input: String = readinput(n: "input")

let parsed = input.split(separator: "\n").map { $0.map { Int($0.asciiValue!)-48 } }
let w = parsed.count

func checkTree(_ sx:Int, _ sy:Int) -> Bool
{
    var (x, y, res) = (sx, sy, 0)
    if x == 0 || y == 0 || x == w-1 || y == w-1 { return true }
    for i in 1...w
    {
        if x - i >= 0     && parsed[sy][x-i] >= parsed[sy][sx] { res |= 1 }
        if x + i <= w - 1 && parsed[sy][x+i] >= parsed[sy][sx] { res |= 2 }
        if y - i >= 0     && parsed[y-i][sx] >= parsed[sy][sx] { res |= 4 }
        if y + i <= w - 1 && parsed[y+i][sx] >= parsed[sy][sx] { res |= 8 }
        if res == 15 { return false }
    }
    return true
}

var res1 = 0;
for y in 0..<w {
    res1 += (0..<w).filter { checkTree($0, y) }.count
}
print(res1)
