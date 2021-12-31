
const fs = require('fs');

const hash=s=>{var h=0;for(var c of s.toString())h=(h<<5)-h+c.charCodeAt(0);return h;}
/** @typedef {{pos:vec3,beacons:vec3[]}} Scanner */
/** @type {<T>(m:T[][])=>T[][]} */
const trp=m=>m[0].map((c,x)=>m.map((l,y)=>m[y][x]))
const cnt=(v,m={})=>++m[v]||(m[v]=1)

class vec3 {
    constructor(x=0,y=0,z=0) {
        if(x instanceof Array) [x,y,z] = x;
        this.x=x; this.y=y; this.z=z;
    }

    add=b=>new vec3(this.x+b.x, this.y+b.y, this.z+b.z);
    sub=b=>new vec3(this.x-b.x, this.y-b.y, this.z-b.z);

    magSq=()=>this.x**2+this.y**2+this.z**2;
    sum=()=>this.x+this.y+this.z;
    magMan=()=>this.abs().sum();
    mag=()=>Math.sqrt(this.magSq());

    distMan=b=>this.sub(b).magMan();
    distSq=b=>this.sub(b).magSq();
    dist=b=>this.sub(b).mag();

    copy=()=>new vec3(this.x, this.y, this.z);
    neg=()=>new vec3(-this.x, -this.y, -this.z);
    abs=()=>new vec3(Math.abs(this.x), Math.abs(this.y), Math.abs(this.z));

    rotX=()=>new vec3(this.x,this.z,-this.y);
    rotY=()=>new vec3(-this.z,this.y,this.x);
    rotZ=()=>new vec3(this.y,-this.x,this.z);

    toString=()=>`(${this.x},${this.y},${this.z})`
    hash=()=>hash(this.toString());
}

var input = ''+fs.readFileSync('19.txt');
var scanner = input.trim().split(/\n*--- /).slice(1)
    .map(l=>({pos:new vec3(0,0,0), beacons: l.split('\n').slice(1)
        .map(p=>new vec3(p.split(',').map(Number))) }))

const sn = 0
checkScanner(sn,scanner.length-1);
console.log(part1(scanner))
console.log(part2(scanner))

/** @param {Scanner[]} scanner */
function part1(scanner)
{
    var bc={};
    for(var s of scanner) 
    for(var b of s.beacons)
    cnt(s.pos.add(b).hash(),bc)
    return Object.keys(bc).length;
}

/** @param {Scanner[]} scanner */
function part2(scanner)
{
    var t,m=0;
    for(var a of scanner)
    for(var b of scanner)
    if(a!=b&&(t=a.pos.distMan(b.pos))>m)m=t;
    return m;
}

function checkScanner(i, n)
{
    if(n) for(var j in scanner)
    if(i!=j && ((i==sn||scanner[i].pos.magMan()) && j!=sn&&!scanner[j].pos.magMan()))
        if(checkRots(scanner[i], scanner[j])) {
            console.log(scanner[i].pos.toString(),i,"=>",j,scanner[j].pos.toString())
            if(!(n=checkScanner(j,n-1))) break;
        }
    return n;
}

/** @type {(s0:Scanner, s1:Scanner)=>boolean} */
function checkRots(s0, s1)
{
    var rot = trp(s1.beacons.map(p=>rots(p)));
    for(var k in rot)
    {
        var cm = {};
        for(var b of s0.beacons)
        for(var a of rot[k])
        if(cnt(a.sub(b).hash(),cm)>11)
        {
            s1.beacons = rot[k];
            s1.pos = s0.pos.add(b).sub(a);
            return true;
        }
    }
    return false;
}

function rots(v) {
    var {x,y,z} = v, t; return [
        v=new vec3(x,y,z), t=v.rotY(), t=t.rotY(), t=t.rotY(),
        v=v.rotX(),        t=v.rotY(), t=t.rotY(), t=t.rotY(),
        v=v.rotX(),        t=v.rotY(), t=t.rotY(), t=t.rotY(),
        v=v.rotX(),        t=v.rotY(), t=t.rotY(), t=t.rotY(),
        v=v.rotZ(),        t=v.rotY(), t=t.rotY(), t=t.rotY(),
        v=v.rotZ().rotZ(), t=v.rotY(), t=t.rotY(), t=t.rotY(),
    ]
}
