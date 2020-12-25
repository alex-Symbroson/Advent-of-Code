fs = require("fs");

var v, m = {};
for(var i = 0; i < 24e6; i++) m[i] = -1;

var s = fs.readFileSync("15.txt").toString().trim()
	.split(",").map((t, i) => (m[t] = i, v=1*t));
console.log(s)

for(var i = s.length; i < 3e7; i++){
	t = m[v] == -1 || m[v] === undefined ? 0 : i - m[v] - 1;
	m[v] = i - 1;
	v = t;
	// if(!(i%3e6))console.log(100*i/30000000|0)
}

console.log(v);
