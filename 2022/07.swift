
import Foundation

let input: String = readinput(n: "input")

var dirs: [String:Int] = [:]
var parsed = input.split(separator: "\n")
    .map { $0.split(separator: " ")}

func parse(_ name:String) -> Int
{
    var sum = dirs[name, default: 0];
    while parsed.count > 0
    {
        let cmd = parsed.removeFirst()
        if cmd == ["$", "cd", ".."] { dirs[name] = sum; return sum; }
        else if cmd[0...1] == ["$", "cd"] { sum += parse(name+"/"+cmd[2]) }
        else if !["dir", "$"].contains(cmd[0]) { sum += Int(cmd[0])! }
    }
    return sum;
}

let goal = parse("") - 40000000;
let res1 = dirs.values.filter { $0 < 100000 }.reduce(0, +)
print(res1)

let res2 = dirs.values.filter { $0 > goal }.min()!
print(res2)
