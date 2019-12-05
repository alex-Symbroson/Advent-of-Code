var s = 0;
foo = v => v >= 9 ? Math.floor(v / 3) - 2 : 0;
foo2 = v => v ? foo(v) + foo2(foo(v)) : 0;

require("fs").readFileSync("aoc-1.txt")
    .toString().split(/\s+/g)
    .map(v => s += foo2(Number(v)));

console.log(s);
