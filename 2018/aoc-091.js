
players = 10;
marbles = 25;

score = [];
marble = [0];
cur = 0;

for(i=0;i<players;i++)score.push(0);

for(var i = 1; i <= marbles; i++) {
    if(!(i % 23)) score[i % players] +=
        i + marble.splice(cur = (cur + marble.length - 7) % marble.length, 1)[0];
    else
        marble.splice(cur = (cur + 2) % marble.length, 0, i);
    //console.log(i+": "+marble.join(","));
}



max = 0;
for(var i = 0; i <= score.length; i++) if(max < score[i]) max = score[i];
console.log(max)
