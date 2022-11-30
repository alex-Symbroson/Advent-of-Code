var t = Date.now();
const toc = () => Date.now()-t;

const ran = m => Math.random()*m|0;
const copy = o => JSON.parse(JSON.stringify(o));
const toDigs = n => n.split('').map(Number)

const remMax = n => toDigs(n).map(d=>9-d).filter(d=>d).reduce((a,b)=>a*b)

console.log("done ", part1(), toc());

function foo(number)
{
    const args = [
        [ 1, 12, 4], [ 1, 11,11], [ 1, 13, 5], [ 1, 11,11],
        [ 1, 14,14], [26,-10, 7], [ 1, 11,11], [26, -9, 4],
        [26, -3, 6], [ 1, 13, 5], [26, -5, 9], [26,-10,12],
        [26, -4,14], [26, -5,14]];

    var x=0, z=0;
    function prog(w,a,b,d)
    {
        x = z%26 + b
        z = Math.trunc(z/a)
        if (x != w) z = z*26 + (w+d)
    }

    number.forEach((d,i)=>args[i].unshift(d))
    for(arg of args) prog(...arg);
    return z
}

function optMax(num, digs, i=0)
{
    if (i==digs.length) return !foo(num) ? num.join('') : false;
    const n = digs[i][0], m = digs[i][1];
    
    for (var d=9; d>=m; d--)
    {
        const t = num[n]; num[n] = d;
        const ret = optMax(num, digs, i+1);
        if (ret) return ret;
        num[n] = t;
    }
}

function findMax(maxn)
{
    number = toDigs(maxn);
    console.log("test ", maxn, toc(), remMax(maxn));
    const digs = number.map((n,i)=>[i,n]).filter(e=>e[1]<9);
    return optMax(number, digs);
}

function part1()
{
    const data = new Array(3).fill(0).map(_=>({
        min:1000, maxn:0,
        cnum:toDigs("99999999999999"),
        minn:"99999999999999"
    }));

    while(1) for(const d of data)
    {
        var number = copy(d.cnum);
        number[ran(14)] = ran(9)+1;
        number[ran(14)] = ran(9)+1;
        number[ran(14)] = ran(9)+1;
        number[ran(14)] = ran(9)+1;
        number[ran(14)] = ran(9)+1;

        const res = foo(number);
        const resn = number.join('');

        if (!d.min && !res)
        {
            if (d.maxn < resn) d.maxn = resn;
            if (remMax(d.maxn) < 1e5) return findMax(d.maxn);
            d.cnum = copy(number);
        }
        else if (d.min > res)
        {
            d.min = res;
            if (resn < d.minn) d.minn = resn;
            d.cnum = copy(number);
            if (!res) console.log("found", d.maxn = d.minn, toc());
        }
    }
}

/*
found 11969557999199 2130
test  92912668988498 3046 17640
done  92915979999498 6761

found 13915968999199 6381
test  82913768999497 7260 20160
done  92915979999498 8188

found 11923458999199 5235
test  82613757999197 5266 258048
done  92915979999498 14270

found 13215979999199 24889
test  82615979999197 24897 21504
done  92915979999498 25330
*/