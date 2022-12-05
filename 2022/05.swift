
import Foundation

let input: String = readinput(n: "input")

let inputs = input
    .split(separator: "\n\n").map { $0.split(separator: "\n") }

let stackData: [[Character]] = inputs[0].map {
    $0.matches(of: try! Regex("... ?")).map{($0.first!.value! as! Substring)[1]} }
let moveData: [[Int]] = inputs[1].map {
    $0.split(separator: try! Regex("move | from | to ")).map { Int($0)! } }

var stacks1: [[Character]] = stackData.reversed().dropFirst().transposed().map { $0.filter { $0 != " " }}
var stacks2 = stacks1;

moveData.forEach {
    let move = stacks1[$0[1]-1].suffix($0[0]);
    stacks1[$0[2]-1].append(contentsOf: move.reversed())
    stacks1[$0[1]-1].removeLast($0[0])

    stacks2[$0[2]-1].append(contentsOf: move)
    stacks2[$0[1]-1].removeLast($0[0])
}

print(String(stacks1.map { $0.last! }))
print(String(stacks2.map { $0.last! }))
