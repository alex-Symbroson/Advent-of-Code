
import Foundation

let input: String = readinput(n: "input")

var ops: [Substring: [Substring]] = [:]
let dops: [Substring: (Int,Int) -> Int] = [ "+": (+), "-": (-), "*": (*), "/": (/) ]

for op in input.split("\n").map({ $0.split(" ") }) {
    ops[op[0].dropLast()] = [Substring](op.dropFirst())
}

let calc: ([Substring]) -> Int = { o in
    Int(o[0]) ?? dops[o[1]]!(
        calc(ops[o[0]] ?? [o[0]]),
        calc(ops[o[2]] ?? [o[2]]))
}

print(calc(ops["root"]!))

let calc2: ([Substring]) -> Substring = { o in
    if nil != Int(o[0]) || o[0] == "x" { return o[0] }
    let _a = calc2(ops[o[0]] ?? [o[0]])
    let _b = calc2(ops[o[2]] ?? [o[2]])
    if let a = Int(_a), let b = Int(_b)
        { return Substring(String(dops[o[1]]!(a, b))) }
    else { return "(\(_a)\(o[1])\(_b))" }
}

ops["root"]![1] = "="
ops["humn"] = ["x"]
print(calc2(ops["root"]!))
