
#include <stdio.h>
#include <stdlib.h>
#include <string>
//#include <string.h>

using namespace std;

#define TARGET 894501

int len = 0, p1, p2;
string s = "37";

//#define P1(i) (p1[i] - '0')
//#define P2(i) (p2[i] - '0')

int main() {
    p1 = 0;
    p2 = 1;
    
    for(int i = 0; i < TARGET + 10; i++) {
        //printf("p: %c %c\n", s[p1], s[p2]);
        s += to_string(s[p1] - '0' + s[p2] - '0');
        p1 = (p1 + s[p1] - '0' + 1) % s.size();
        p2 = (p2 + s[p2] - '0' + 1) % s.size();
        //getchar();
    }
    printf("%.*s\n", 10, s.c_str() + TARGET);
    return 0;
}

