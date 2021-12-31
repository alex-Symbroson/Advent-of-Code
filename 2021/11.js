var map =
`3113284886
2851876144
2774664484
6715112578
7146272153
6256656367
3148666245
3857446528
7322422833
8152175168`
.split("\n").map(l=>l.split("").map(Number))
const w=map[0].length;
const h = map.length;

function flash(x, y)
{
    if(map[y][x]==-1)return;
    map[y][x] = -1;
    if(map[y][x].flash) return console.log("hoho");
    //console.log("flash",x,y)
    numflash++;
    for(var a=-1;a<=1;a++)
    for(var b=-1;b<=1;b++)
    if(a||b)inc(x+a,y+b);
}

function inc(x, y)
{
    if(x<0||y<0||x>=w||y>=h||map[y][x]==-1)return;
    if(++map[y][x] > 9) flash(x, y);
}

for(var i=0;;i++)
{
    var numflash = 0;
    for(var y in map)
        for(var x in map[y]) inc(1*x, 1*y)
    for(var y in map)
        for(var x in map[y]) 
            if(map[y][x]==-1)map[y][x]=0;
    if (numflash == w*h)break;
}
console.log(i+1,numflash)
