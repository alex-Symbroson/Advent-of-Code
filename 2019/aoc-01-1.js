var s = 0;
foo = v => v >= 9 ? Math.floor(v / 3) - 2 : 0;

require("fs").readFileSync("aoc-1.txt")
    .toString().split(/\s+/g)
    .map(v => s += foo(Number(v)));

console.log(s);
