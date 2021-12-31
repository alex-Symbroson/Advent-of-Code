var num = [[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]
var num = [[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]

var tos=JSON.stringify
var l=(x,m)=>(console.log(m?m+x:x),x)
var copy = o=>JSON.parse(tos(o))

console.log("initial      ", tos(num))
console.log("res ", tos(step(num)))

function step(num)
{
    //console.log("####",tos(num))
    if(r=testRec(num, 0)) {
        //if(r[0]) addR(num[0],r[0]);
        //if(r[1]) addL(num[1],r[1]);
        console.log("after explode", tos(num))
        console.log("---",r)
        return step(num);
    }
    else if(testSplit(num)) {
        console.log("after   split", tos(num))
        return step(num)
    }
    else return num;

    function testSplit(l)
    {
        if(typeof l[0] == "object") { if(testSplit(l[0])) return true; }
        else if(l[0] >= 10) return l[0] = [l[0]/2|0,0.5+l[0]/2|0]
        if(typeof l[1] == "object") { if(testSplit(l[1])) return true; }
        else if(l[1] >= 10) return l[1] = [l[1]/2|0,0.5+l[1]/2|0]
        return false;
    }
    function testRec(l, n)
    {
        if(n==4) return copy(l);
        var r = null;

        if(typeof l[0] == "object")
            if(r = testRec(l[0], n+1))
            {
                //console.log(tos(l),r)
                if(typeof l[1] == "number") l[1]+=r[1], r[0]&&r[1]&&(l[0]=r[1]=0);
                if(r[0]) tryAddL(l,r[0]);
                return r;
            }
        if (r) return r;

        if(typeof l[1] == "object") 
            if(r=testRec(l[1], n+1))
            {
                //console.log(tos(l),r)
                if(typeof l[0] == "number") l[0]+=r[0], r[0]&&r[1]&&(l[1]=r[0]=0);
                if(r[1]) tryAddR(l,r[1]);
                return r;
            }
        return r;
    }

    function addL(l,n){
        //console.log("addL",n,tos(l))
        if(typeof l[0] == 'number') l[0]+=n
        else addL(l[0],n)
    }
    function tryAddR(l,n){
        console.log("TaddL",n,tos(l))
        if(!l[1]||typeof l[1]=='object')return;
        addL(l[0],n)
    }

    function addR(l,n){
        //console.log("addR",n,tos(l))
        if(typeof l[1] == 'number') l[1]+=n
        else addL(l[1],n)
    }
    function tryAddL(l,n){
        console.log("TaddR",n,tos(l))
        if(!l[0]||typeof l[0]=='object')return;
        addR(l[1],n)
    }
}