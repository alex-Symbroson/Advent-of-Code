
var fs = require('fs');

fs.readFile('05.txt', 'utf8', (err, data) => {
    var rep = false;
    var tdata = data.replace(/\n/g, "");
    var lst = [];
    for (var i = "a".charCodeAt(0); i <= "z".charCodeAt(0); i++) {
        data = tdata.replace(RegExp(String.fromCharCode(i), "gi"), "");
        do {
            var rep = false;
            data = data.replace(/([a-z])\1+/gi, (m) => {
                return m.replace(/[A-Z][a-z]|[a-z][A-Z]/g, () => {
                    rep = true;
                    return "";
                });
            });
        } while (rep);
        lst.push(data.length + ":" + String.fromCharCode(i));
    }
    console.log(lst.sort((a, b) => { return a < b ? 1 : -1; })[0]);
});
