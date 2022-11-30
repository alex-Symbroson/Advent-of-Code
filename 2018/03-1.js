
var fs = require('fs');
var area = new Array(1000).fill(0).map(x=>new Array(1000).fill(0));

var n = 0;
String(fs.readFileSync('03.txt')).trim().split("\n")
    .map(l => l.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/).slice(1,6).map(Number))
    .forEach(function(rect)
    {
        for (var x = rect[1]; x < rect[1] + rect[3]; x++)
            for (var y = rect[2]; y < rect[2] + rect[4]; y++)
                if (area[y][x]++ == 1) n++;
    });
console.log(n);

