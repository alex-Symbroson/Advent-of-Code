
import Foundation

let input: String = readinput(n: "input")

typealias Parsed = [[[(Substring, Int, Substring, Int, Substring)]]]

let parsed: Parsed = input.split(separator: "\n").map {
    $0.split(separator: ".").map {
        $0.matches(of: try! Regex("Each (\\w+) robot costs (\\d+) (\\w+)( and (\\d+) (\\w+))?"))
          .map { ($0[1].substring!, Int($0[2].substring!)!, $0[3].substring!, Int($0[5].substring ?? "0")!, $0[6].substring ?? "") }
    }
}

let ores = ["ore", "clay", "obsidian", "geode"]

let thds1: [CustomThread] = (0..<parsed.count).map { CustomThread($0, 24).start() }
let thds2: [CustomThread] = (0..<3).map { CustomThread($0, 32).start() }
print(thds1.map { $0.join()*$0.bp }.reduce(0, +))
print(thds2.map { $0.join() }.reduce(1, *))

class CustomThread: Thread
{
    let (bp, tmax): (Int, Int)
    let waiter = DispatchGroup()
    var recp: [Int:[(Int, Int)]] = [:]
    var (gmax, kmax) = (0, [0,0,0,0])

    init(_ p: Int, _ t: Int)
    {
        (bp, tmax) = (p + 1, t)
        super.init()
        parsed[p].forEach { $0.forEach { a, b, c, d, e in
            let i = ores.firstIndex(of: String(a)) ?? -1
            let ib = ores.firstIndex(of: String(c)) ?? -1
            let id = ores.firstIndex(of: String(e)) ?? -1
            if ib > -1 && kmax[ib] < b { kmax[ib] = b }
            if id > -1 && kmax[id] < d { kmax[id] = d }
            recp[i] = [(b, ib)]
            if d > 0 { recp[i]!.append((d, id)) }
        } }
    }

    override func main() {
        buy([0,0,0,0], [1,0,0,0])
        waiter.leave()
    }

    func start() -> CustomThread { waiter.enter(); super.start(); return self }
    func join() -> Int { waiter.wait(); print(bp, gmax); return gmax }

    func buy(_ _res:[Int], _ _bots:[Int], _ _z:Int = 0, _ build: Int? = nil)
    {
        var (res, bots, z) = (_res, _bots, _z)
        var act: [Int] = [], lact: [Int] = []

        if let b = build {
            for (n, i) in recp[b]! { res[i] -= n }
            bots[b] += 1
        }

        while true
        {
            (lact, act) = (act, getActions(res, bots))
            // build resources
            for i in 0..<bots.count { res[i] += bots[i] }

            z += 1 // timer
            if z == tmax
            { if res[3] > gmax { gmax = res[3]; }; break }

            if act != lact // purchase new
            { for b in act { buy(res, bots, z, b) } }
        }
    }

    func getActions(_ res:[Int], _ bots:[Int]) -> [Int]
    {
        var acts: [Int] =  []
        for i in recp.keys.reversed() {
            if (i == 3 || bots[i] < kmax[i]) && nil == recp[i]!.first(where: { n, k in res[k] < n })
            { if i == 3 { return [3]; } else { acts.append(i) } } // i==3 might be suboptimal
        }
        return acts
    }
}