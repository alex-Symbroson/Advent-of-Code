var p = (
"LA,PF,VU,FS,AJ,RK,ZT,GW,HK,TU,KB,CY,WN,EM,NJ,BS,OD,XD,MQ,SJ,"+
"UY,IJ,DJ,QY,JY,ZD,KE,UJ,IY,AB,BQ,ZS,FE,BI,CS,OS,VO,CB,GM,OY,"+
"HN,DY,ZO,KW,MY,OJ,PE,CQ,ID,FI,WB,WM,ND,ZM,MU,RI,SY,LB,SD,RG,"+
"UD,CN,RT,KU,WE,HE,XM,GI,CU,NB,XS,GH,TX,PN,BY,SQ,CE,FD,HJ,BU,"+
"BJ,PI,NX,MJ,XI,LP,TB,TK,DQ,WX,AY,GD,RZ,UQ,GO,GQ,GY,PY,IQ,FC,LK"
).split(",").sort(asc);

var o1 = {}, o2 = {}, s = "";

p.forEach((r) => {
    if(!o1[r[0]]) o1[r[0]] = 1;
    else o1[r[0]]++;
    if(!o2[r[0]]) o2[r[0]] = 0;
    
    if(!o2[r[1]]) o2[r[1]] = 1;
    else o2[r[1]]++;
    if(!o1[r[1]]) o1[r[1]] = 0;
});

function asc(a, b) { return a < b ? -1 : 1; }

while(1) {
    if(!(c = Object.keys(o2).filter((k) => { return !o2[k]; }).sort(asc)[0])) break;
    s += c;
    p.forEach((r) => { if(c == r[0]) o2[r[1]]--; });
    o2[c]--;
    c = Object.keys(o2).filter((k) => { return !o2[k]; }).sort(asc)[0];
};

console.log(s);
