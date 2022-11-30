
// gcc 161.c -o 161.out && ./161.out

#include <stdio.h>
#include <stdint.h>

#define TRROPR(OPR, ID) if((inp[opr[1]] OPR inp[opr[2]]) == out[opr[3]]) \
    cnt++, *ccalc |= 1 << ID, printf(" rr" TOS(OPR))

#define TRIOPR(OPR, ID) if((inp[opr[1]] OPR     opr[2] ) == out[opr[3]]) \
    cnt++, *ccalc |= 1 << ID, printf(" ri" TOS(OPR))

#define TIROPR(OPR, ID) if((    opr[1]  OPR inp[opr[2]]) == out[opr[3]]) \
    cnt++, *ccalc |= 1 << ID, printf(" ir" TOS(OPR))

#define TOS(o) "" #o


uint32_t
    calc[1000], // x >> 16: oprid; (x << 16 >> 16) & (1 << oprid) : poss. oprids
    calcs = 0,
    ops[16], // oprs of oprid
    rem = 16;


void print16bin(uint32_t i) {
    printf("%i:", i >> 16);
    for(int j = 15; j >= 0; j--)
        printf("%c", i & 1 << j ? '1' : '0');
}

void apply(uint32_t ccalc) {
    
    uint32_t oprs = ccalc << 16 >> 16;
    ops[ccalc >> 16] = oprs;
    rem--;
    printf("rem: %i\n", rem);
    
    for(int i = 0; i < calcs; i++)
        if(calc[i] >> 16 == ccalc >> 16) calc[i] = 0;
        else if(calc[i] & oprs) {
            printf("applying "); print16bin(ccalc);
            printf(": "); print16bin(calc[i]);
            printf(" -> "); calc[i] &= ~oprs;
            print16bin(calc[i]); printf("\n");
            
            if(__builtin_popcount(calc[i] << 16 >> 16) == 1) {
                printf("apply found 2: ");
                print16bin(calc[i]);
                printf("\n");
                
                apply(calc[i]);
                calc[i] = 0;
            }
        }
}

int main() {
    FILE* f = fopen("160.txt", "r");
    
    if(!f) {
        fprintf(stderr, "couldn't open file\n");
        return 1;
    }
    
    int inp[4], opr[4], out[4], cnt, pt1 = 0, *ccalc = calc;
    for(int i = 0; i < 16; i++) ops[i] = 0;
    
    while(fscanf(f,
        "Before: [%i, %i, %i, %i]\n"
        "%i %i %i %i\n"
        "After: [%i, %i, %i, %i]\n\n",
        inp + 0, inp + 1, inp + 2, inp + 3,
        opr + 0, opr + 1, opr + 2, opr + 3,
        out + 0, out + 1, out + 2, out + 3
    ) == 12) {
        printf(
            "(%i, %i, %i, %i) # (%i %i %i %i) = (%i, %i, %i, %i]\n",
            inp[0], inp[1], inp[2], inp[3],
            opr[0], opr[1], opr[2], opr[3],
            out[0], out[1], out[2], out[3]
        );
        
        
        cnt = 0;
        TRROPR(+,   0); TRIOPR(+,   1); // add
        TRROPR(*,   2); TRIOPR(*,   3); // mul
        TRROPR(&,   4); TRIOPR(&,   5); // and
        TRROPR(|,   6); TRIOPR(|,   7); // or
        TRROPR(+0*, 8); TIROPR(+0*, 9); // ass
        TIROPR(>,  10); TRIOPR(>,  11); TRROPR(>,  12); // gt
        TIROPR(==, 13); TRIOPR(==, 14); TRROPR(==, 15); // eq
        
        *ccalc |= opr[0] << 16; // store used opr id
        
        if(1 || rem > 0) {
            printf("\napplying current: ");
            for(int i = 0; i < 16; i++) if(ops[i])
                if(i == opr[0]) *ccalc = 0, printf("%i,", i);
                else *ccalc &= ~ops[i], printf("%i,", i);
            printf("\n");
            
            if(__builtin_popcount(*ccalc << 16 >> 16) == 1) {
                printf("apply found 1 %i: ", *ccalc << 16 >> 16);
                print16bin(*ccalc);
                printf("\n");
                
                apply(*ccalc);
                *ccalc = 0;
            }
        }
        
        //printf("\n");
        ccalc++; calcs++;
        if(cnt >= 3) ++pt1;
        
        //getchar();
    }
    
    printf("\nPart1: %i\n\n", pt1);
    
    // calc oprs
    int rem = 16;
    for(int i = 0; i < 16; i++) {
        print16bin(ops[i]);
        printf("\n");
    }
    
    while(fscanf(f,
        "%i %i %i %i\n",
        opr + 0, opr + 1, opr + 2, opr + 3
    ) == 4) {
        
    }
    
    fclose(f);
}
