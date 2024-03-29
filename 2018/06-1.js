
var fs = require('fs');

p = [[300,90],[300,60],[176,327],[108,204],[297,303],[101,236],
    [70,102],[336,153],[260,265],[228,221],[119,267],[310,302],
    [291,164],[190,202],[298,228],[292,262],[53,251],[176,64],
    [170,160],[71,42],[314,51],[71,88],[319,150],[192,322],[270,88],
    [165,203],[262,340],[301,327],[135,324],[97,250],[161,231],
    [305,344],[295,213],[320,219],[172,269],[151,150],[215,128],
    [167,102],[158,138],[307,353],[358,335],[163,329],[234,147],
    [58,298],[228,50],[151,334],[108,176],[335,235],[296,263],[80,233]];

p = new String(fs.readFileSync('06.txt'))
    .split("\n").map(l=>l.split(", ").map(Number))

const X=200
lst = [], area = new Array(p.length).fill(0);

for(var y = 0; y < X; y++) { 
    lst.push([]);
    for(var x = 0; x < X; x++) {
        var dmin = -1, t, imin = -2;
        p.forEach((p, i, l) => {
            if(dmin == -1 || (t = Math.abs(x - (p[0] + 50)) + Math.abs(y - (p[1] + 50))) <= dmin) {
                if(t == dmin) imin = -1;
                else imin = i;
                dmin = t;
            }
        });
        lst[y].push(imin);
        if(imin != -1) area[imin]++;
    }
}

for(var i = 0; i < X; i++) {
    area[lst[i][  0]] = 0;
    area[lst[i][X-1]] = 0;
    area[lst[  0][i]] = 0;
    area[lst[X-1][i]] = 0;
}

vmax = 0;
lst2 = [];
area.forEach((v, i) => {
    if(v != 0) lst2.push(i);
    if(vmax < v) console.log(i + ": " + (vmax = v));
})
console.log(lst2.join(","));

s = "";
for(y = 0; y < X; y += 10) {
    for(x = 0; x < X; x += 10)
        s += "\033[1;3" + (lst[y][x]%8).toString() + "m" + ("00" + lst[y][x].toString()).slice(-2);
    s += "\n";
}
console.log(s);
