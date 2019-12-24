var s =
`_     _
 #####
 .#.#.
 .#..#
 ....#
 ..###
_     _`
.split('\n').map(l => l.split(''))

var lays = {};

while(1)
{
    var t = [new Array(8).join(' ').split('')]
    for(var y = 1; y <= 5; y++)
    {
        t.push([' '])
        for(var x = 1; x <= 5; x++)
        {
            var c = (s[y - 1][x] + s[y + 1][x] + s[y][x - 1] + s[y][x + 1]).split('#').length - 1;
            if(s[y][x] == '#') t[y].push(c == 1 ? '#' : '.');
            else t[y].push(c == 1 || c == 2 ? '#' : '.');
        }
    }
    t.push(t[0])

    var div = calcDiv((s = t).toString());
    if(lays[div]) break;
    else lays[div] = div;
    /*console.log("\033[2;0H"+s.join('\n').replace(/,/g, '').replace(/ /g, ''));
    for(_=50000000;_--;);*/
}

console.log(div);

function calcDiv(x) {
    return ('0' + x).match(/#|\.|0/g).reduce(
    (a, b, i) => b == '#' ? a | 1 << i - 1 : a);
}
