var beg = 197487, end = 673251, s = "";
for(var i = beg; i <= end; i++) s += "," + i.toString() + ",\n";
console.log(
    s.match(/,1*2*3*4*5*6*7*8*9*,/g).join("\n")
     .match(/,\d*(\d)\1\d*,/g).length);
