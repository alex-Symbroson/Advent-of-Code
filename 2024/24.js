let [state, conns] = app.ReadFile("test.txt").split("\n\n")
map = {}

state.split('\n').forEach(l => {
    l = l.split(': ')
    map[l[0]] = Number(l[1])
})

conns.split('\n').forEach(ll => {
    l = ll.match(/(\w+) (\w+) (\w+) -> (\w+)/)
    if (!l) return alert("oops: " + ll)
    map[l[4]] = l.slice(1, 4)
})
allvars = new Set(Object.keys(map).filter(v => v[0] != 'x' && v[0] != 'y'))

swap = (va, vb) => {
    var t = map[va]
    map[va] = map[vb]
    map[vb] = t
}

// [["z07", "njc", "kbk", "mkm", "tgj"], ["z08", "btr", "bjm", "tgj", "mkm"], 
// ["z13", "pmv", "rbk", "wrg", "rtn"], ["z14", "vhb", "bpf", "vjf", "hsw"], 
// ["z18"], ["z19", "scd", "rrq", "tgm", "skf"], 
// ["z26", "qkf", "wkr", "kvp", "qsm"], ["z27", "bpb", "crd", "frt", "nvr"]]

sw = ["z07,bjm", "hsw,z13", "skf,z18"]//,"wkr,nvr"]
app.SetClipboardText(sw.join(',').split(',').sort())
sw.map(s => swap(...s.split(",")))

app.WriteFile('input.txt', '')
var ss = Object.keys(map).filter(v => v[0] == 'z').sort().map(v => [v])
ss.map(l => {
    do {
        rr = false
        l0 = []
        l1 = (l[0].replace(/\b(z\d+|[a-z]{3})\b/g, v => (rr = true, l0.push('\t' + v + ' => ' + map[v].join(' ')), '(' + map[v].join(' ') + ')')))
        l.unshift(l0.join('\n'))
        l.unshift(l1)
    } while (rr)
    app.WriteFile('input.txt', l.reverse().join('\n').replace(/AND/g, '&').replace(/XOR/g, '^').replace(/OR/g, '|') + '\n\n', "append")
})

op = { AND: (a, b) => a & b, OR: (a, b) => a | b, XOR: (a, b) => a ^ b }
ops = ""
oplist = []
varlist = []
okset = new Set()
function calc(v, b) {
    var expr = map[v]
    if (expr.length) varlist.push(v)
    var sop = expr.length ? '(' + expr.join(' ') + ')' : v
    if (b !== undefined) ops = v + '=' + sop
    else ops = ops.replace(v, sop)

    if (typeof expr == "number") return expr
    var ret = op[expr[1]](calc(expr[0]), calc(expr[2]))
    if (b !== undefined) oplist.push('ops: ' + ops)
    return ret
}

function run(n = 50) {
    oplist = []
    varlist = []
    var r = Object.keys(map).filter(l => l[0] == "z").sort().map((v, i) => i <= n ? calc(v, n) : 0)
    return r.reduce((a, b, i) => a + b * 2 ** i, 0)
}
fmt = (n, i = 2) => ('00' + n).slice(-i)

alert(run()) // part1

res = []
vars = Object.entries(map)
var nx = vars.filter(e => e[0][0] == 'x').length
var ny = vars.filter(e => e[0][0] == 'y').length

for (var i = 0; i < nx; i++) {
    map['x' + fmt(i)] = 0
    map['y' + fmt(i)] = 0
}

var lfaults = []
for (var i = 0; i < nx; i++) {
    map['x' + fmt(i)] = 1
    v = run(i)
    res.push([i, 'x', v, v == 2 ** i])
    map['x' + fmt(i)] = 0
    if (v == 1 << i) varlist.forEach(v => okset.add(v))
}
alert(res.join('\n'))
