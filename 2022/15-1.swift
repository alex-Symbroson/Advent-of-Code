
import Foundation

let input: String = readinput(n: "input")

let parsed: [Regex<AnyRegexOutput>.Match] = input
    .matches(of: try! Regex("Sensor at x=([0-9-]+), y=([0-9-]+): closest beacon is at x=([0-9-]+), y=([0-9-]+)"))

let beacons = parsed.map { (
    Int($0[1].substring!)!, Int($0[2].substring!)!, 
    Int($0[3].substring!)!, Int($0[4].substring!)!) }

let vmin = beacons.map { min($0.0, $0.2) }.min()!
let vmax = beacons.map { max($0.0, $0.2) }.max()!

var sum = 0
let h = 2000000
for i in (vmin-vmax...3*vmax/2)
{
    if nil != beacons.firstIndex(where: { ($0.2,$0.3) != (i,h) &&
        abs($0.0-i)+abs($0.1-h) <= abs($0.0-$0.2)+abs($0.1-$0.3)})
    { sum += 1 }
}
print(sum)
