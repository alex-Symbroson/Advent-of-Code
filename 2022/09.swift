
import Foundation

let input: String = readinput(n: "input")
let parsed: [(Character, Int)] = input
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .split(separator: "\n")
    .map { ($0[0], Int($0.split(separator: " ")[1])!) }

var nodes = Array(repeating: (0, 0), count: 10)
var vis1: [String : Bool] = [:], vis9: [String : Bool] = [:]

for (dir, n) in parsed
{
    let d = "UL".contains(dir) ? -1 : 1

    for _ in 1...n
    {
        if "LR".contains(dir) { nodes[0].0 += d }
        if "DU".contains(dir) { nodes[0].1 += d }

        for i in 1..<nodes.count
        {
            let dx = nodes[i-1].0 - nodes[i].0
            let dy = nodes[i-1].1 - nodes[i].1
            if abs(dx) == 2 || abs(dx) == 1 && abs(dy) == 2
                { nodes[i].0 += dx > 0 ? 1 : -1 }
            if abs(dy) == 2 || abs(dy) == 1 && abs(dx) == 2
                { nodes[i].1 += dy > 0 ? 1 : -1 }
        }
        vis1["\(nodes[1].0),\(nodes[1].1)"] = true
        vis9["\(nodes.last!.0),\(nodes.last!.1)"] = true
    }
}

print((vis1.count, vis9.count))
