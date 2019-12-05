
var fs = require('fs'), rects = [];

fs.readFile('030.txt', 'utf8', function(err, data) {
    n = 0;
    data.split("\n").forEach(function(rect) {
        if(rect) {
            var rect = JSON.parse(rect);
            rect.push(true);
            rect[3] += rect[1];
            rect[4] += rect[2];
            rects.push(rect);
        }
    });

    for (var i in rects)
        for (var j = i*1 + 1; j < rects.length; j++)
            if ((i != j) && (rects[i][5] || rects[j][5]) &&
                rects[i][1] < rects[j][3] && rects[i][3] > rects[j][1] &&
                rects[i][2] < rects[j][4] && rects[i][4] > rects[j][2])
                rects[i][5] = rects[j][5] = false;

    console.log(rects.filter((v) => { return v[5]; })[0][0]);
});
