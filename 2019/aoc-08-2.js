var msg = null, s = require("fs").readFileSync("aoc-08.txt").toString().trim();

s.match( /.{150}/g ).forEach( l => msg = msg ? msg.replace( /2/g, (m, i) => l[i]) : l)

console.log(msg.match(/.{25}/g).join("\n").replace(/0/g, " ").replace(/1/g, "$"));
