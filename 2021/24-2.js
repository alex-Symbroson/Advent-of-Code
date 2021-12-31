
/* function prog(w,a,b,c,d) {
    console.log(a,b,c,d,'  ',x,y,z,w)
    x=z%26+b
    z=Math.trunc(z/a)
    x=!(x==w)?1:0
    y=c*x+1
    z*=y
    y=(w+d)*x
    z+=y
}
*/

function foo(number)
{
    var args = [
    [ 1, 12, 4],
    [ 1, 11,11],
    [ 1, 13, 5],
    [ 1, 11,11],
    [ 1, 14,14],
    [26,-10, 7],
    [ 1, 11,11],
    [26, -9, 4],
    [26, -3, 6],
    [ 1, 13, 5],
    [26, -5, 9],
    [26,-10,12],
    [26, -4,14],
    [26, -5,14]]


    var _b='mlnloqlrxnvqwv'
    var _d='elflohlegfjmoo'
    var x=0,y=0,z=0,w=0;
    function prog(w,a,b,d)
    {
        //x = w^+d^ +b
        //z = a-1 ? z : z^
        x=z%26+b
        //console.log(z%26,b,x,z)
        z=Math.trunc(z/a)
        //console.log(1*!!(a-1),z,z*26+(w+d))
        if (x != w) z=z*26+(w+d)
        //console.log(z)
    }

    number.forEach((d,i)=>args[i].unshift(d))

    for(arg of args) {
        prog(...arg);
    }
    return z
}


//                 ? 7    .
var number = "11115998999227".split('').map(Number)

console.log(foo(number))

//process.exit();

min = 5000;
ran = ()=>Math.random()*14|0
var cnum = "21711513977281".split('').map(Number)
const copy = o => JSON.parse(JSON.stringify(o))

var digs = cnum.map((n,i)=>[i,n]).filter(e=>e[1]>1)
opt(cnum,digs)

function test(num)
{
    if(foo(num)==0) console.log(num.join(''))
}

function opt(num, digs)
{
    var num = copy(num);
    var digs = copy(digs)
    var dig = digs.shift()
    
    if(!dig) return test(num)

    for(var d=dig[1];d>=1;d--)
    {
        num[dig[0]]=d
        opt(num,digs)
    }
}
