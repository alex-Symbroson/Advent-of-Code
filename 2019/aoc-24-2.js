var s =
`.     .
 #####
 .#.#.
 .#..#
 ....#
 ..###
.     .`
.split('\n').map(l => l.split(''))

// genenrate layers
var lays = {}, _s = JSON.stringify(s).replace(/#/g, '.');
for(var i = -111; i <= 111; i++)
    lays[i] = i == 0 ? s : JSON.parse(_s);

for(var n = 1; n <= 200; n++)
{
    var tlays = JSON.parse(JSON.stringify(lays))
    for(var i = -110; i <= 110; i++)
    {
        var s = lays[i], t = ["       ".split('')];
        for(var y = 1; y <= 5; y++)
        {
            t.push([' ']);
            for(var x = 1; x <= 5; x++)
            {
                if(x == 3 && y == 3) { t[y].push('?'); continue; }
                var c = count(s[y - 1][x] + s[y + 1][x] + s[y][x - 1] + s[y][x + 1], '#');
                if(x == 3 && y == 2) c += count(lays[i + 1][1].join(''), '#');
                if(x == 3 && y == 4) c += count(lays[i + 1][5].join(''), '#');
                if(x == 2 && y == 3) c += count(lays[i + 1].map(l => l[1]).join(''), '#');
                if(x == 4 && y == 3) c += count(lays[i + 1].map(l => l[5]).join(''), '#');
                if(x == 1 && lays[i - 1][3][2] == '#') c++;
                if(x == 5 && lays[i - 1][3][4] == '#') c++;
                if(y == 1 && lays[i - 1][2][3] == '#') c++;
                if(y == 5 && lays[i - 1][4][3] == '#') c++;
                if(s[y][x] == '#') t[y].push(c == 1 ? '#' : '.');
                else  t[y].push( c == 1  ||  c == 2 ? '#' : '.');
            }
        }
        t.push("       ".split(''))
        tlays[i] = t;
    }
    lays = tlays

    /* // output
    console.log("\n\n\n\n\n\n")
    for(var i = -10; i <= 10; i++)
        for(var j = 1; j <= 5; j++)
            console.log("\033[" + `${1+j};${(i+10)*7}H` + lays[i][j].join(''));
    console.log(n + ": " + count(JSON.stringify(lays),'#'))
    for(var _ = 1e8; --_;);*/
}

console.log(count(JSON.stringify(lays),'#'))

function count(s, c) { return (s.match(/#/g) || "").length; }
