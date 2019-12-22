
var len = 10007, pos = 2019, cmds = [];

require('fs').readFileSync("aoc-22.txt").toString()
.replace(/(cut|deal)[^-\d\n]*(-?\d*)/g, function(m, name, cnt) {
    cnt = Number(cnt)
    if(name[0] == 'c') pos = (pos + len - cnt) % len;
    else if(cnt == 0) pos = len - pos - 1;
    else {
        while(pos % cnt != 0) pos += len;
        pos = cnt * pos % len;
    }
});

console.log(pos)
