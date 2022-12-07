import Foundation

let input: String = readinput(n: "input")

let s = input

for i in 0..<input.count-4 {
    let t = s.prefix(i+14).suffix(14)
    if Set(t).count == 14 { print(i+14); break }
}
