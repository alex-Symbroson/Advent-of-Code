prog = `#ip 5\naddi 5 16 5\nseti 1 8 2
seti 1 1 1
mulr 2 1 4
eqrr 4 3 4
addr 4 5 5
addi 5 1 5
addr 2 0 0
addi 1 1 1
gtrr 1 3 4
addr 5 4 5
seti 2 8 5
addi 2 1 2
gtrr 2 3 4
addr 4 5 5
seti 1 7 5
mulr 5 5 5
addi 3 2 3
mulr 3 3 3
mulr 5 3 3
muli 3 11 3
addi 4 6 4
mulr 4 5 4
addi 4 5 4
addr 3 4 3
addr 5 0 5
seti 0 0 5
setr 5 3 4
mulr 4 5 4
addr 5 4 4
mulr 5 4 4
muli 4 14 4
mulr 4 5 4
addr 3 4 3
seti 0 3 0
seti 0 0 5
`

prog = prog.split('\n').map((s) =>	{
    return s.split(' ').map((t,i) => {
        return i ? Number(t) : t;
    });
});

var reg = [1,0,0,0,0,0], ip = 0, ipb = 0;

ops = {
    'addr': (a,b,c) => { return reg[c] = reg[a] + reg[b]; },
    'addi': (a,b,c) => { return reg[c] = reg[a] + b; },
    'mulr': (a,b,c) => { return reg[c] = reg[a] * reg[b]; },
    'muli': (a,b,c) => { return reg[c] = reg[a] * b; },
    'banr': (a,b,c) => { return reg[c] = reg[a] & reg[b]; },
    'bani': (a,b,c) => { return reg[c] = reg[a] & b; },
    'borr': (a,b,c) => { return reg[c] = reg[a] | reg[b]; },
    'bori': (a,b,c) => { return reg[c] = reg[a] | b; },
    'setr': (a,b,c) => { return reg[c] = reg[a]; },
    'seti': (a,b,c) => { return reg[c] = a; },
    'gtir': (a,b,c) => { return reg[c] = a > reg[b] ? 1 : 0; },
    'gtri': (a,b,c) => { return reg[c] = reg[a] > b ? 1 : 0; },
    'gtrr': (a,b,c) => { return reg[c] = reg[a] > reg[b] ? 1 : 0; },
    'eqri': (a,b,c) => { return reg[c] = a == reg[b] ? 1 : 0; },
    'eqir': (a,b,c) => { return reg[c] = reg[a] == b ? 1 : 0; },
    'eqrr': (a,b,c) => { return reg[c] = reg[a] == reg[b] ? 1 : 0; },
    '#ip': (a) => { ipb = a; }
}

function foo(){ alert(JSON.stringify(arguments)); }
function fmt(i,n){return ("             ".slice(-n)+i.toString()).slice(-n)};
ops[prog[0][0]].apply(reg, prog.shift().slice(1));

while(ip < prog.length) {
    var cmd = prog[ip];
    reg[ipb] = ip;
    var s = fmt(ip,2) + ": [" + reg.map((i)=>{return fmt(i,9)}).join(",") + "] -> ";
    ops[cmd[0]].apply(reg, cmd.slice(1));
    ip = reg[ipb] + 1;
    if(reg[1]>10501373)console.log(s + "[" + reg.map((i)=>{return fmt(i,9)}).join(",") + "]");
    //for(i=0;i<10000000;i++);
};
console.log(ip + ": [" + reg.join(",") + "]");

