
//var a=-1,x1=20,x2=30,y1=-10,y2=-5
var a=-1,x1=150,x2=193,y1=-136,y2=-86
var maxdy=-y1-1;

var v0 = maxdy+0.5
var t = v0
var y = -t*t/2+v0*t
console.log(y);

var x=0,y=0,dy=maxdy, ys=[];
for(var i=0; y>=y1; i++)
{
    y+=dy; dy-=1; ys.push(y);
}
// console.log(ys);
console.log(Math.max.apply(0,ys));





var n=0
for(var mdx = 0;mdx<=1000;mdx++)
for(var mdy = -(maxdy-1);mdy<=(maxdy-1);mdy++)
{
    var x=0,y=0,dx=mdx,dy=mdy;
    for(var i=0;x<=x2&&y>=y1 && !(x1<=x&&x<=x2 && y1<=y&&y<=y2);i++)
    {
        x+=dx;y+=dy;dx-=Math.sign(dx);dy-=1;
        ys.push(y)
    }
    //console.log(Math.max.apply(0,ys))

    if(x1<=x&&x<=x2 && y1<=y&&y<=y2) {n++; (mdx+","+mdy);}
}

console.log(n)