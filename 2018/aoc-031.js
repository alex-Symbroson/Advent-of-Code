
var fs   = require('fs'),
    area = new Array(1000).fill(0).map(() => {
        return new Array(1000).fill(0);
    });

fs.readFile('030.txt', 'utf8', function(err, data) {
    var n = 0;
    data.split("\n").forEach(function(rect) {
        if(rect) {
            rect = JSON.parse(rect);
            for (var x = rect[1]; x < rect[1] + rect[3]; x++)
                for (var y = rect[2]; y < rect[2] + rect[4]; y++)
                    if (area[y][x]++ == 1) n++;
        }
    });
    console.log(n);
});
