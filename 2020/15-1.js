fs = require("fs");

s = fs.readFileSync("15.txt").toString();
s = s.trim().split(",").map(i=>1*i);

console.log(s)

for(var i=s.length;i<2020;i++){
	var p = s.lastIndexOf(s[i-1], i-2);
	s.push(p == -1 ? 0 : s.length-p-1);
}
console.log(s[i-1]);
