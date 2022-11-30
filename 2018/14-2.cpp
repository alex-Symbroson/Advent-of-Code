
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <string.h>

using namespace std;

#define TARGET "430971"

string s = "37";

int main() {
    int p1 = 0, p2 = 1, i = 0, n = 0;
    
    do {
        s += to_string(s[p1] - '0' + s[p2] - '0');
        p1 = (p1 + s[p1] - '0' + 1) % s.size();
        p2 = (p2 + s[p2] - '0' + 1) % s.size();
        if(!strncmp(TARGET, &s[0] + i, strlen(TARGET))) break;
        n++;
    } while(++i);

    printf("%i\n", n);
    return 0;
}

