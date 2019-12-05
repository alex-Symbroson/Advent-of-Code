
//benutze kein javascript wenn du keine webanwendung schreibst

var fs = require('fs');

fs.readFile('050.txt', 'utf8', (err, data) => {
    var rep = false;
    data = data.replace(/\n/g, "");
    do {
        var rep = false;
        data = data.replace(/([a-z])\1+/gi, (m) => {
            return m.replace(/[A-Z][a-z]|[a-z][A-Z]/g, () => {
                rep = true;
                return "";
            });
        });
    } while (rep);
    console.log(data.length);
});

