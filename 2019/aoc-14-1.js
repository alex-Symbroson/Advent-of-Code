//7 A, 1 B => 1 C

var o = { ORE: Res("ORE", 1) };
var t;

function Res(name, amt) {
    return { name, cnt: 0, ovr:0, amt: Number(amt), src: [] };
}

require('fs').readFileSync("aoc-14.txt").toString()
.replace(/(.*) => (.*)/g, "$2 = $1")
.replace(/(\d+) (\w+)( = )?/g, (m, amt, name, pre) =>
    pre ?
        t = o[name] = new Res(name, amt) :
        t.src.push(new Res(name, amt)))

function expl(res, amt, w) {
    if(amt < res.ovr) res.ovr -= amt, amt = 0;
    else amt -= res.ovr, res.ovr = 0;

    // how many times do reaction
    var exc = Math.ceil(amt / res.amt);
    var crt = exc * res.amt;

    res.cnt += crt;
    res.ovr += crt - amt;

    res.src.forEach(function(src) {
        expl(o[src.name], exc * src.amt, w + "  ");
    });
}

expl(o.FUEL, 1, "");
console.log(o.ORE.cnt)
