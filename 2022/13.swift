
import Foundation

let input: String = readinput(n: "input")

enum NList : CustomStringConvertible
{
    indirect case list([NList])
    case num(Int)

    var description : String { 
        switch self {
            case .num(let a): return a.description
            case .list(let a): return a.description.replacing(" ", with: "")
        }
    }
}

func unwrap(_ s: inout String) -> NList
{
    if s[0] == "["
    {
        var list: [NList] = []
        if s[1] == "]" { s.removeFirst(2); return NList.list(list) }
        while s.removeFirst() != "]" { list.append(unwrap(&s)); }
        return NList.list(list)
    }
    else
    {
        var num = ""
        while !s.isEmpty && s.first!.isNumber { num.append(s.removeFirst()) }
        return .num(Int(num)!)
    }
}

func compare(_ l: NList, _ r: NList) -> Int?
{
    if case (.num(let a), .num(let b)) = (l, r) 
        { return b - a }
    if case (.num(_), .list(let b)) = (l, r)
        { return b.isEmpty ? -1 : compare(.list([l]), r) }
    if case (.list(let a), .num(_)) = (l, r)
        { return a.isEmpty ? 1 : compare(l, .list([r])) }
    if case (.list(let a), .list(let b)) = (l, r)
    {
        for i in 0..<min(a.count, b.count)
        { if let res = compare(a[i], b[i]), res != 0 { return res } }
        if a.count != b.count { return b.count - a.count }
    }
    return nil
}

let parsed = (input + "\n[[6]]\n[[2]]").split(separator: "\n")
    .map { var s = String($0); return unwrap(&s) }

let res1 = (0..<parsed.count/2).reduce(0, 
    { compare(parsed[$1 * 2], parsed[$1 * 2 + 1])! > 0 ? $0 + $1 + 1 : $0 })
print(res1)

let sorted = parsed.sorted { compare($0, $1)! > 0 }.map { "\($0)" }
let res2 = (1 + sorted.firstIndex(of: "[[2]]")!) * (1 + sorted.firstIndex(of: "[[6]]")!)
print(res2)
