
//benutze kein javascript wenn du keine webanwendung schreibst

var fs = require('fs');

fs.readFile('040.txt', 'utf8', function(err, data) {
    var guards = {}, guard, best = 0, bestg, bestmin, last;
        
    data.split("\n").forEach(function(s) {
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
    
});






