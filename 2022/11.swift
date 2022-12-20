
import Foundation

class Monkey
{
    var num = 0, insp = 0
    var items: [Int] = [], nextitems: [Int] = []
    var op_mul = false
    var op_val: String = "", test_div = 0
    var test_pos = 0, test_neg = 0
}

let input: String = readinput(n: "input")
var monkeys: [Monkey] = []
var lcm = 1

for m in input.matches(of: try Regex("""
    Monkey (\\d):
      Starting items:(( \\d+,?)+)
      Operation: new = old ([+*]) (.*)
      Test: divisible by (\\d+)
        If true: throw to monkey (\\d+)
        If false: throw to monkey (\\d+)
    """))
{
    let mk = Monkey()
    
    mk.num = Int(m[1].substring!)!
    mk.items = m[2].substring!.split(separator: ",").map { Int($0.dropFirst())! }
    mk.op_mul = m[4].substring! == "*"
    mk.op_val = String(m[5].substring!)
    mk.test_div = Int(m[6].substring!)!
    mk.test_pos = Int(m[7].substring!)!
    lcm *= mk.test_div
    mk.test_neg = Int(m[8].substring!)!
    monkeys.append(mk)
}

print(loop(20, 3))
print(loop(10000, 1))

func loop(_ n:Int, _ d:Int) -> Int
{
    let mks = monkeys
    for _ in 1...n
    {
        for mk in mks
        {
            mk.insp += mk.items.count
            while mk.items.count > 0
            {
                let i = mk.items.removeFirst()
                let op_val = mk.op_val == "old" ? i : Int(mk.op_val)!
                let op_res = ((mk.op_mul ? op_val * i % lcm : op_val + i) / d)
                if op_res % mk.test_div == 0
                    { mks[mk.test_pos].items.append(op_res) }
                else { mks[mk.test_neg].items.append(op_res) }
            }
            mk.items = mk.nextitems
            mk.nextitems = []
        }
    }
    return mks.map { $0.insp }.sorted().suffix(2).reduce(1, *)
}
