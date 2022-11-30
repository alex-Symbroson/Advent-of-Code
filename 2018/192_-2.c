#include <stdio.h>

int main() {
    long unsigned int r0, r1, r2, r3 = 10551373;
    
    r2 = 1;
    //for(r3 = 1; r3 <= 30; r3++) {
        r0 = 0;
        for(r1 = 1; r1 <= r3; r1++)
            if(!(r3 % r1)) r0 += r1;
        //if(!(r2%1055)) printf("%lu%%%%\n", r2/1055);
        printf("%lu:%lu\n", r3, r0);
    //}
}

