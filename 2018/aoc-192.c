
// gcc 161.c -o 161.out && ./161.out

#include <stdio.h>
#include <stdint.h>

#define CALCRR(OPR) (inp[opr[1]] OPR inp[opr[2]])
#define CALCRI(OPR) (inp[opr[1]] OPR     opr[2] )
#define CALCIR(OPR) (    opr[1]  OPR inp[opr[2]])

int main() {
    FILE* f = fopen("190_.txt", "r");
    
    if(!f) {
        fprintf(stderr, "couldn't open file\n");
        return 1;
    }
    
    int inp[6] = {1, 0, 0, 0, 0, 0}, ip = 0, ipb, prog[4][40], prlen = 0, *opr;
    
    // execute program
    #define EXEC(ID, TYPE, EXEC) case ID: inp[opr[3]] = CALC##TYPE(EXEC); break;
    if(fscanf(f, "#ip %i\n", &ipb) != 1) return 1;
    
    while(fscanf(f, "%i %i %i %i\n", prog[ip] + 0,
        prog[ip] + 1, prog[ip] + 2, prog[ip] + 3) == 4) {
        ip++;
    }
    fclose(f);
    
    prlen = ip;
    ip = 0;
    while(ip < prlen) {
        opr = prog[ip];
        inp[ipb] = ip;
        printf("%i: [%i,%i,%i,%i,%i,%i] opr: %i %i %i %i ", ip,
            inp[0],inp[1],inp[2],inp[3],inp[4],inp[5],
            opr[0],opr[1],opr[2],opr[3]);
        
        switch(*opr) {
            EXEC( 0, RR,   +); EXEC( 1, RI,   +);
            EXEC( 2, RR,   *); EXEC( 3, RI,   *);
            EXEC( 4, RR,   &); EXEC( 5, RI,   &);
            EXEC( 6, RR,   |); EXEC( 7, RI,   |);
            EXEC( 8, RR, +0*); EXEC( 9, IR, +0*);
            EXEC(10, IR,   >); EXEC(11, RI,   >); EXEC(12, RR,  >);
            EXEC(13, IR,  ==); EXEC(14, RI,  ==); EXEC(15, RR, ==);
        }
        ip = inp[ipb] + 1;
        
        printf("%i: [%i,%i,%i,%i,%i,%i]\n",ip,inp[0],inp[1],inp[2],inp[3],inp[4],inp[5]);
    }
    
    printf("Part 1: %i  %i\n", *inp);
    return 0;
}
