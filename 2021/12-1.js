var f=`LA-sn
LA-mo
LA-zs
end-RD
sn-mo
end-zs
vx-start
mh-mo
mh-start
zs-JI
JQ-mo
zs-mo
start-JQ
rk-zs
mh-sn
mh-JQ
RD-mo
zs-JQ
vx-sn
RD-sn
vx-mh
JQ-vx
LA-end
JQ-sn`

f=`start-A
start-b
A-c
A-b
b-d
A-end
b-end`

var m={},n=0
foo=x=>({start:'^',end:'$'}[x]||x);
f.split("\n").map(l=>{
    l=l.split("-").map(foo);
    
    if(!m[l[0]]) m[l[0]]=[];
        if(!m[l[1]]) m[l[1]]=[];
        if(l[1]!='^') m[l[0]].push(l[1])
    if(l[0]!='^')m[l[1]].push(l[0])
})
small=c=>c.match(/[a-z]/)?c:'';

function go(c, vis)
{
 //   alert(c+'   '+vis)
    if(c=='$')return n++;
    for(var d of m[c])
    if(vis.indexOf(d)==-1)
    go(d, [...vis,small(d)]);
}

//Called when application is started.
function OnStart()
{
   alert(JSON.stringify(m))
    go('^', '');
    alert(n)
}
