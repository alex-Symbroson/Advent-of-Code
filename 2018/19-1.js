prog = `#ip 1
addi 1 16 1
seti 1 1 3
seti 1 9 5
mulr 3 5 2
eqrr 2 4 2
addr 2 1 1
addi 1 1 1
addr 3 0 0
addi 5 1 5
gtrr 5 4 2
addr 1 2 1
seti 2 6 1
addi 3 1 3
gtrr 3 4 2
addr 2 1 1
seti 1 6 1
mulr 1 1 1
addi 4 2 4
mulr 4 4 4
mulr 1 4 4
muli 4 11 4
addi 2 6 2
mulr 2 1 2
addi 2 2 2
addr 4 2 4
addr 1 0 1
seti 0 3 1
setr 1 4 2
mulr 2 1 2
addr 1 2 2
mulr 1 2 2
muli 2 14 2
mulr 2 1 2
addr 4 2 4
seti 0 0 0
seti 0 4 1`

prog = prog.split('\n').map((s) =>	{
    return s.split(' ').map((t,i) => {
        return i ? Number(t) : t;
    });
});

var reg = [1,0,0,0,0,0], ip = 0, ipb = 0;

ops = {
    'addr': (a,b,c) => reg[c] = reg[a] + reg[b],
    'addi': (a,b,c) => reg[c] = reg[a] + b,
    'mulr': (a,b,c) => reg[c] = reg[a] * reg[b],
    'muli': (a,b,c) => reg[c] = reg[a] * b,
    'banr': (a,b,c) => reg[c] = reg[a] & reg[b],
    'bani': (a,b,c) => reg[c] = reg[a] & b,
    'borr': (a,b,c) => reg[c] = reg[a] | reg[b],
    'bori': (a,b,c) => reg[c] = reg[a] | b,
    'setr': (a,b,c) => reg[c] = reg[a],
    'seti': (a,b,c) => reg[c] = a,
    'gtir': (a,b,c) => reg[c] = a > reg[b] ? 1 : 0,
    'gtri': (a,b,c) => reg[c] = reg[a] > b ? 1 : 0,
    'gtrr': (a,b,c) => reg[c] = reg[a] > reg[b] ? 1 : 0,
    'eqri': (a,b,c) => reg[c] = a == reg[b] ? 1 : 0,
    'eqir': (a,b,c) => reg[c] = reg[a] == b ? 1 : 0,
    'eqrr': (a,b,c) => reg[c] = reg[a] == reg[b] ? 1 : 0,
    '#ip': (a) => ipb = a
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
    console.log(s + "[" + reg.map((i)=>{return fmt(i,9)}).join(",") + "]");
    //for(i=0;i<10000000;i++);
};
console.log(ip + ": [" + reg.join(",") + "]");
