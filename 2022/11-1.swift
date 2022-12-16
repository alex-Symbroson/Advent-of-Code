
import Foundation

let input: String = readinput(n: "input")

class Monkey
{
    var num = 0
    var items: [Int] = []
    var nextitems: [Int] = []
    var op_mul = false
    var op_val: String = "", test_div = 0
    var test_pos = 0, test_neg = 0
    var insp = 0

    init() {}
}

var monkeys: [Monkey] = []
var kgv = 1

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
    mk.nextitems = m[2].substring!.split(separator: ",").map { Int($0.dropFirst())! }
    mk.op_mul = m[4].substring! == "*"
    mk.op_val = String(m[5].substring!)
    mk.test_div = Int(m[6].substring!)!
    mk.test_pos = Int(m[7].substring!)!
    kgv *= mk.test_div
    mk.test_neg = Int(m[8].substring!)!
    monkeys.append(mk)
}

for _ in 1...20
{
    for mk in monkeys
    {
        mk.items = mk.nextitems
        mk.nextitems = [] 
        mk.insp += mk.items.count
        while mk.items.count > 0
        {
            let i = mk.items.removeFirst()
            let op_val = mk.op_val == "old" ? i : Int(mk.op_val)!
            let op_res = (mk.op_mul ? op_val * i : op_val + i) / 3
            // print([mk.num, op_val, mk.op_mul ? "*" : "+", i, "=", op_res, op_res % Int(mk.test_div), op_res % Int(mk.test_div) == 0 ? mk.test_pos : mk.test_neg])
            if op_res % Int(mk.test_div) == 0
                { monkeys[mk.test_pos].nextitems.append(op_res) }
            else { monkeys[mk.test_neg].nextitems.append(op_res) }
        }
    }
}

// print(monkeys.map { $0.nextitems })
print(monkeys.map { $0.insp }.sorted().suffix(2).reduce(1, *))