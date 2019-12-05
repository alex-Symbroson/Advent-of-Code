
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

using namespace std;

#define TARGET "5158916779" //"894501"
#define LEN 100000

char s[LEN] = "37", *sp, *p;
int len = 2;

#define CHECK (printf("%c%c==%.*s\n",*p,p[1],2,TARGET), *p == TARGET[0] && *chk(&p) == TARGET[1])

char** chk(p) {
    return *p == s + LEN ? *p = s : p;
}

int main() {
    int p1 = 0, p2 = 1, i = 0, n = 0, sum;
    p = sp = s + 1;
    
    do {
        sum = s[p1 % LEN] - '0' + s[p2 % LEN] - '0';
        //printf("%i\n",sum);
        if(sum >= 10) {
            *chk(&++sp) = sum / 10 + '0', ++len;
            if(CHECK) break;
        }
        *inc(sp) = '0' + sum % 10, ++len;
        if(CHECK) break;
        
        p1 = ((p1 + s[p1] - '0' + 1) % len) % LEN;
        p2 = ((p2 + s[p2] - '0' + 1) % len) % LEN;
        
        if((p1 > p2 ? p1 - p2 : p2 - p1) > LEN)
            printf("err d:%i\n",p1-p2),getchar();
            
        printf("(%i) %.*s\n", p1 - p2, LEN, s);
        /*printf("%.*s.%.*s",
            len > LEN ? (len % LEN) : 0, s,
            len > LEN ? LEN - (len % LEN) : 12, s + (len > LEN ? len % LEN : 0));
        */
        getchar();
        
        ++n;
    } while(++i);

    printf("%i\n", n);
    return 0;
}

