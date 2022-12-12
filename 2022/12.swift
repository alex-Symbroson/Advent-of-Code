
import Foundation

let input: String = readinput(n: "input")

public class Coord2D: Hashable
{
    let x: Int, y: Int
    var h: Int

    init(_ x: Int, _ y: Int, _ h: Int)
    { self.x = x; self.y = y; self.h = h; }

    public func hash(into hasher: inout Hasher)
    { hasher.combine([x, y]) }

    public static func == (left: Coord2D, right: Coord2D) -> Bool 
    { left.hashValue == right.hashValue }
}

var start: Coord2D?, end: Coord2D?, y = 0;
var parsed = input.split(separator: "\n")
var nodes: [[Coord2D]] = Array(repeating: [], count: parsed.count)

for y in 0..<parsed.count
{
    for x in 0..<parsed[y].count
    {
        let res = Coord2D(x, y, Int(parsed[y][x].asciiValue!));
        if parsed[y][x].asciiValue! == 83 { res.h = 97; start = res; }
        if parsed[y][x].asciiValue! == 69 { res.h = 122; end = res; }
        nodes[y].append(res)
    }
}

func heuristicCost(p: Coord2D) -> Int { return 1 } 
// { return abs(p.x - start!.x) + abs(p.y - start!.y) }

func adj(_ x: Int, _ y: Int, _ a: Int, _ b: Int) -> Bool
{ return nodes[y][x].h - nodes[b][a].h < 2 }

func nextNodes(_ p: Coord2D) -> [Coord2D]
{
    var next : [Coord2D] = []
    let x = p.x, y = p.y
    if x > 0 && adj(x, y, x - 1, y) { next.append(nodes[y][x - 1]) }
    if y > 0 && adj(x, y, x, y - 1) { next.append(nodes[y - 1][x]) }
    if x + 1 < nodes[y].count && adj(x, y, x + 1, y) { next.append(nodes[y][x + 1]) }
    if y + 1 < nodes.count && adj(x, y, x, y + 1) { next.append(nodes[y + 1][x]) }
    return next
}

let path1 = AStar<Coord2D>.find(nextNodes, { $0 == start }, heuristicCost, start: end!)
let path2 = AStar<Coord2D>.find(nextNodes, { $0.h == 97 }, heuristicCost, start: end!)

print((path1?.count ?? 0) - 1)
print((path2?.count ?? 0) - 1)

/*
print(nodes.map {
    $0.map {
        let res = Character(UnicodeScalar($0.h)!)
        return path!.contains($0) ? "\u{1b}[7m\(res)\u{1b}[0m" : String(res) 
    }.joined(separator: "")
}.joined(separator: "\n"))
*/

