
players = 476;
marbles = 71431;
// > 384205 = part 1

score = [];
marble = [0];
cur = 0;

for(i=0;i<players;i++)score.push(0);

for(var i = 1; i <= marbles; i++) {
    if(!(i % 23)) {
        cur = (cur + marble.length - 7) % marble.length;
        score[i % players] += i + marble.splice(cur, 1)[0];
    } else
        marble.splice(cur = (cur + 2) % marble.length, 0, i);
    
    if(!(i % 23)) {
        var max = 0;
        for(var n = 0; n <= score.length; n++) if(max < score[n]) max = score[n];
        //console.log(i + ": " + max);
    }
    if((100 * i) % marbles == 0) console.log(100 * i / marbles);
}

max = 0;
for(var i = 0; i < score.length; i++) if(max < score[i]) max = score[i];
console.log(max)
