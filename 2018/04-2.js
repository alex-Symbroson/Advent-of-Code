
//benutze kein javascript wenn du keine webanwendung schreibst

var fs = require('fs');

var data = new String(fs.readFileSync('04.txt'))
var guards = {}, guard, best = 0, bestg, bestmin, last;
toDate = s=>new Date(s.slice(1, p = s.indexOf(']')))

data.split("\n")
.sort((a,b)=>toDate(a)-toDate(b))
.forEach(function(s)
{
    var d = new Date(s.slice(1, p = s.indexOf(']')));
    
    l = s.slice(p + 2).split(' ');
    
    switch(l[0]) {
        case "Guard":
            if(guards[l[1]] == undefined) {
                guards[l[1]] = [];
                guard = guards[l[1]];
                for(var i = 0; i < 60; i++) guard.push(0);
                guard.id = l[1];
            } else guard = guards[l[1]];
        break;
        
        case "falls": last = d; break;
        
        case "wakes":
            var diff = (d - last) / 6e4;
            var g = d.getMinutes();
            if(g < t) g += 60;
            
            for(var t = last.getMinutes(); t < g; t++) {
                guard[t % 60]++;
                if(best < guard[t % 60]) {
                    best = guard[t % 60];
                    bestmin = t % 60;
                    bestg = guard.id;
                }
            }
        break;
    }
});

console.log(
    bestg + ' : ' + bestmin + ' : ' + best +
    " => " + (bestmin * bestg.slice(1))
);
