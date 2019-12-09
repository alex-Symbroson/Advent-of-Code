var s = require("fs").readFileSync("aoc-08.txt").toString().trim();
var min = -1, ll = "";

function count(s, c) { return s.split(c).length - 1; }

s.match( /\d{150}/g ).forEach(
    (l, t) => ((t = count(l, '0')) < min || min == -1) && (ll = l, min = t));

console.log(count(ll, '1') * count(ll, '2'));
