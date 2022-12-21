import Foundation

let input: String = readinput(n: "input")
let (p, parsed) = (811589153, input.split("\n"))
var l = (0..<parsed.count).map { i in [Int(parsed[i])! * p, i] }
let (ll, w) = (l, l.count - 1)

for k in 1...10
{
    for n in ll
    {
        let i = l.firstIndex(of: n)!
        l.remove(at: i)
        l.insert(n, at: (i + n[0] % w + w) % w)
    }
}

let n = l.map { $0[0] }.firstIndex(of: 0)!
print(l[(n + 1000) % l.count][0] + l[(n + 2000) % l.count][0] + l[(n+3000) % l.count][0])
