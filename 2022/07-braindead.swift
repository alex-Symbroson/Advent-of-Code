
import Foundation

let input: String = readinput(n: "input")

class Ref<T> {
    var value: T?
    init(_ value: T?) { self.value = value }
}

enum FS {
    indirect case dir(String, Ref<[String:Ref<FS>]>, Ref<Int>, Ref<FS>)
    case file(String, Int)

    mutating func add(node: FS)
    {
        switch self {
            case let .dir(_, d, _, _):
                d.value![node.getName()] = Ref(node)
                var c = Ref(self)
                while c.value != nil
                {
                    c.value!.getDir().2.value! += node.getSize();
                    c = c.value!.getDir().3
                }
            default: fatalError("cant add to non dir")
        }
    }

    func getDir() -> (String, Ref<[String:Ref<FS>]>, Ref<Int>, Ref<FS>) {
        if case let .dir(n, d, s, p) = self { return (n, d, s, p)}
        else { fatalError("not a directory") }
    }

    func getFile() -> (String, Int) {
        if case let .file(n, s) = self { return (n, s)}
        else { fatalError("not a file") }
    }

    func getName() -> String {
        if case let .dir(n, _, _, _) = self { return n }
        else if case let .file(n, _) = self { return n }
        else { fatalError("wtf") }
    }

    func getSize() -> Int {
        if case let .dir(_, _, s, _) = self { return s.value! }
        else if case let .file(_, s) = self { return s }
        else { fatalError("wtf") }
    }
}

var cur = FS.dir("root", Ref([:]), Ref(0), Ref<FS>(nil))
var dir = FS.dir("/", Ref([:]), Ref(0), Ref(cur))
cur.add(node: dir)

for line in input.split(separator: "\n")
{
    let m = line.split(separator: " ").map { String($0) }
    let (n, d, _, p) = cur.getDir()

    switch m[0]
    {
        case "$":
            if m[1] == "cd" {
                if m[2] == ".." { 
                    if p.value == nil { fatalError("meh " + n) }
                    else { cur = p.value! }
                } else {
                    guard let t = d.value![m[2]]
                    else { fatalError("file not found " + m[2]) }
                    cur = t.value!
                }
            }
        case "dir":
            cur.add(node: FS.dir(m[1], Ref([:]), Ref(0), Ref(cur)))
        default:
            cur.add(node: FS.file(m[1], Int(m[0])!))
    }
}

var sum = 0;
func calcSum(_ d: FS)
{
    if case .file = d { return }
    if d.getDir().2.value! <= 100000 { sum += d.getDir().2.value! }
    for (k, v) in d.getDir().1.value!
    { if v.value != nil { calcSum(v.value!) } }
}

calcSum(dir)
print(sum)

var min = 70000000;
let goal = 30000000 - (min - dir.getSize());
func calcMin(_ d: FS)
{
    if case .file = d { return }
    if d.getDir().2.value! < goal { return }
    
    if min - goal > d.getDir().2.value! - goal {
        min = d.getDir().2.value!
    }

    for (k, v) in d.getDir().1.value!
    { if v.value != nil { calcMin(v.value!) } }
}

calcMin(dir)
print(min)
