
var fs = require('fs');
p = new String(fs.readFileSync('07.txt'))
    .replace(/Step (.) must be finished before step (.) can begin.\n?/g, "$1$2,")
    .split(",").sort(asc);

var o1 = {}, o2 = {}, s = "";

p.forEach((r) => {
    if(!o1[r[0]]) o1[r[0]] = 1;
    else o1[r[0]]++;
    if(!o2[r[0]]) o2[r[0]] = 0;
    
    if(!o2[r[1]]) o2[r[1]] = 1;
    else o2[r[1]]++;
    if(!o1[r[1]]) o1[r[1]] = 0;
});

function asc(a, b) { return a < b ? -1 : 1; }

while(1) {
    if(!(c = Object.keys(o2).filter((k) => { return !o2[k]; }).sort(asc)[0])) break;
    s += c;
    p.forEach((r) => { if(c == r[0]) o2[r[1]]--; });
    o2[c]--;
    c = Object.keys(o2).filter((k) => { return !o2[k]; }).sort(asc)[0];
};

console.log(s);
