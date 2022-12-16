
import Foundation

let input: String = readinput(n: "input")
// typealias BigInt = _BigInt<UInt>
struct Point: Hashable { let x: Int64, y: Int64 }

let parsed: [Regex<AnyRegexOutput>.Match] = input
    .matches(of: try! Regex("Sensor at x=([0-9-]+), y=([0-9-]+): closest beacon is at x=([0-9-]+), y=([0-9-]+)"))

let beacons = parsed.map { (
    Int64(Int($0[1].substring!)!), Int64(Int($0[2].substring!)!), 
    Int64(Int($0[3].substring!)!), Int64(Int($0[4].substring!)!)) }

let dmax = Int64(4000000)

var lines1: [(Point, Point)] = []
var lines2: [(Point, Point)] = []
for (a, b, c, d) in beacons
{
    let d = abs(a-c) + abs(b-d) + 1
    lines1.append((Point(x:a+d, y:b), Point(x:a, y:b+d)))
    lines2.append((Point(x:a+d, y:b), Point(x:a, y:b-d)))
    lines2.append((Point(x:a-d, y:b), Point(x:a, y:b+d)))
    lines1.append((Point(x:a-d, y:b), Point(x:a, y:b-d)))
}

var intersections: Set<Point> = []
for (p1, p2) in lines1
{
    for (p3, p4) in lines2
    {
        let p = intersectLines2(p1,p2,p3,p4) 

        if  
            p.x >= min(p1.x, p2.x) &&
            p.x <= max(p1.x, p2.x) &&
            p.x >= 0 && p.x <= dmax &&
            p.y >= 0 && p.y <= dmax
        { intersections.insert(p) }
    }
}

for p in intersections
{
    if nil == beacons.firstIndex(where: {
        abs($0.0-p.x)+abs($0.1-p.y) <= abs($0.0-$0.2)+abs($0.1-$0.3)})
    { print((p.x, p.y, p.x*dmax + p.y)); break; }
}

func intersectLines2(_ p1:Point, _ p2:Point, _ p3:Point, _ p4:Point) -> Point
{
    let m1 = (p2.x-p1.x).signum() * (p2.y-p1.y).signum()
    let m2 = (p4.x-p3.x).signum() * (p4.y-p3.y).signum()
    let b1 = p1.y - m1 * p1.x
    let b2 = p3.y - m2 * p3.x
    let x = (b1 - b2) / (m2 - m1)
    return Point(x:x, y:m1 * x + b1)
}
