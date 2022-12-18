
import Foundation

var input: String = readinput(n: "input")

var stones = [
    ["####"],
    [".#.", "###", ".#."],
    ["..#", "..#", "###"],
    ["#", "#", "#", "#"],
    ["##", "##"]
]
let mh = 100, mw = 7
var (dh, maxh) = (mh, 0)
var map = [String](repeating: ".......", count: mh)

for _ in 1...2022
{
    let s = stones.first!
    let y = dh - s.count
    var (x, dy) = (2, -3)
    fix(s, x, y + dy, "@")

    while true
    {
        fix(s, x, y + dy, ".")
        if input.first == "<" && x > 0 && !coll(s, x - 1, y + dy) { x -= 1 }
        if input.first == ">" && x + s[0].count < mw && !coll(s, x + 1, y + dy) { x += 1 }
        fix(s, x, y + dy, "@")
        input.append(input.removeFirst())
        
        if y + dy + s.count >= mh || coll(s, x, y + dy + 1) { break }
        fix(s, x, y + dy, ".")
        dy += 1
        fix(s, x, y + dy, "@")
    }

    fix(s, x, y + dy, "#")
    if dy - s.count < 0 { 
        dh += dy - s.count
        maxh -= dy - s.count
    }

    while dh < 10 {
        map.removeLast()
        map.insert(".......", at: 0)
        dh += 1
    }

    stones.append(stones.removeFirst())
}
print(maxh)

func coll(_ s:[String], _ x:Int, _ y:Int) -> Bool
{
    for b in 0..<s.count {
        for a in 0..<s[b].count {
            if s[b][a] != "#" { continue }
            if map[y+b][x+a] == "#" { return true }
        }
    }
    return false
}

func fix(_ s:[String], _ x:Int, _ y:Int, _ c:Character)
{
    for b in 0..<s.count {
        for a in 0..<s[b].count {
            if s[b][a] != "#" { continue }
            var row = Array(map[y+b])
            row[x+a] = s[b][a] == "#" ? c : "."
            map[y+b] = String(row)
        }
    }
    if c == "." { return }
}
