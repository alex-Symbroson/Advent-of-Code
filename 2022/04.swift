import Foundation

let input: String = readinput(n: "input")

let parsed = input
    .split(separator: "\n")
    .map {
        let l = $0.split(separator: try!Regex("-|,")).map { Int($0)! }
        return (l[0]...l[1], l[2]...l[3])
    }

let res1 = parsed.filter { $0.0.contains($0.1) || $0.1.contains($0.0) }
print(res1.count)

let res2 = parsed.filter { $0.0.overlaps($0.1) }
print(res2.count)
