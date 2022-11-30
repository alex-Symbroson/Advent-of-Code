
var fs = require('fs'), rects = [];

var rects = String(fs.readFileSync('03.txt')).trim().split("\n")
    .map(l => l.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/).slice(1,6).map(Number))
    .map(r => [r[0], r[1], r[2], r[3]+r[1], r[4]+r[2], true]);

for (var i in rects)
    for (var j = i*1 + 1; j < rects.length; j++)
        if ((i != j) && (rects[i][5] || rects[j][5]) &&
            rects[i][1] < rects[j][3] && rects[i][3] > rects[j][1] &&
            rects[i][2] < rects[j][4] && rects[i][4] > rects[j][2])
            rects[i][5] = rects[j][5] = false;

console.log(rects.filter(v => v[5])[0][0]);

