
var len = 119315717514047n, cmdsr = [];

// parse shuffle algorithm
require('fs').readFileSync("aoc-22.txt").toString()
.replace(/(cut|deal)[^-\d\n]*(-?\d*)/g, function(m, name, cnt) {
    cmdsr.unshift([name[0], BigInt(cnt)]);
});

// initialize fr_quad
var qdr = { 1: [
    f_rev(2n) - f_rev(1n),
    f_rev(0n) + len ** 10n
]};

// calculate 2020 start pos
var pos = 2020n, bdig = 101741582076661n.toString(2).split("").reverse();
bdig.forEach( function(d, i) {
    if(d == "1") pos = fr_quad(pos, BigInt(i + 1));
});

console.log(pos);

// reverse shuffle
function f_rev(pos) {
    for(var cmd of cmdsr) {
        if(cmd[0] == 'c') pos = (pos + len + cmd[1]) % len;
        else if(cmd[1] == 0n) pos = len - pos - 1n;
        else {
            while(pos % cmd[1] != 0n) pos += len;
            pos = pos / cmd[1];
        }
    }
    return pos % len
}

// reverse shuffle e^(2^x) times
function fr_quad(x, e) {
    if(e == 0) return dr;
    if(!qdr[e]) {
        if(!qdr[e - 1n]) fr_quad(0n, e - 1n);
        var t = qdr[e - 1n];
        qdr[e] = [t[0] ** 2n % len, t[1] * (1n + t[0]) % len];
    }
    return (x * qdr[e][0] + qdr[e][1]) % len;
}

//function mod(x, m) { return (x % m + m) % m; }
