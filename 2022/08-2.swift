
import Foundation

let input: String = readinput(n: "input")

let parsed = input.split(separator: "\n").map { $0.map { Int($0.asciiValue!) - 48 } }
let w = parsed.count

func checkTree(_ sx: Int, _ sy: Int) -> Int
{
    let (x, y) = (sx, sy)
    var res = (0, 0, 0, 0, 0);
    for i in 1...w
    {
        if x - i >= 0     && res.0 & 1 == 0 { res.1 += 1 }
        if x + i <= w - 1 && res.0 & 2 == 0 { res.2 += 1 }
        if y - i >= 0     && res.0 & 4 == 0 { res.3 += 1 }
        if y + i <= w - 1 && res.0 & 8 == 0 { res.4 += 1 }
        if x - i >= 0     && parsed[sy][x-i] >= parsed[sy][sx] { res.0 |= 1 }
        if x + i <= w - 1 && parsed[sy][x+i] >= parsed[sy][sx] { res.0 |= 2 }
        if y - i >= 0     && parsed[y-i][sx] >= parsed[sy][sx] { res.0 |= 4 }
        if y + i <= w - 1 && parsed[y+i][sx] >= parsed[sy][sx] { res.0 |= 8 }
    }
    return res.1 * res.2 * res.3 * res.4
}

var res2 = 0;
for y in 0..<w {
    res2 = max(res2, (0..<w).map { checkTree($0, y) }.max()!)
}
print(res2)
