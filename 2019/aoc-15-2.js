var s = require("fs").readFileSync("aoc-15-1.dat").toString();

for (var time = 1; s.indexOf(".") > -1; time++) {
	var t = s.split("\n");
	s = s.replace(/\.(X)\.|\.X|X\./g, "XX$1").split("\n");
	for (var y = 2; y < 43; y++)
		for (var x = 29; x < 71; x++)
			if (t[y][x] == 'X') {
				if (t[y + 1][x] == '.') s[++y] = s[y].slice(0, x) + "X" + s[y--].slice(x + 1);
				if (t[y - 1][x] == '.') s[--y] = s[y].slice(0, x) + "X" + s[y++].slice(x + 1);
			}
    // output & delay
	s = s.join("\n");
	console.log("\033[0;0H" + s.replace(/X/g, " ") + time);
    for(var _ = 0;_ < 2e7; _ ++);
}

// console.log(time - 1);
