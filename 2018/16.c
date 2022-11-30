
// gcc 161.c -o 161.out && ./161.out

#include <stdio.h>
#include <stdint.h>

#define CALCRR(EXEC) (inp[opr[1]] EXEC inp[opr[2]])
#define CALCRI(EXEC) (inp[opr[1]] EXEC     opr[2] )
#define CALCIR(EXEC) (    opr[1]  EXEC inp[opr[2]])

#define TEST(ID, TYPE, EXPR) if(CALC##TYPE(EXPR) == out[opr[3]]) cnt++, *ccalc |= 1 << ID

uint32_t
    calc[1000], // x >> 16: oprid; (x << 16 >> 16) & (1 << oprid) : poss. oprids
    calcs = 0,
    ops[16], // oprs of opr.id
    rem = 16;

// apply found operator to other operations
void apply(uint32_t ccalc)
{
    uint32_t oprs = ccalc << 16 >> 16;
    ops[ccalc >> 16] = oprs;
    rem--;
    
    for(int i = 0; i < calcs; i++) {
        if(!calc[i]) continue;
        if(calc[i] >> 16 == ccalc >> 16) calc[i] = 0;
        else if(calc[i] & oprs) {
            calc[i] &= ~oprs;
            
            if(__builtin_popcount(calc[i] << 16 >> 16) == 1) {
                apply(calc[i]);
                calc[i] = 0;
            }
        }
    }
}

int main()
{
    FILE* f = fopen("16.txt", "r");
    //initDTime();
    
    if(!f) {
        fprintf(stderr, "couldn't open file\n");
        return 1;
    }
    
    unsigned int inp[4], opr[4], out[4], cnt, pt1 = 0, *ccalc = calc;
    for(int i = 0; i < 16; i++) ops[i] = 0;
    
    while(fscanf(f,
        "Before: [%i, %i, %i, %i]\n"
        "%i %i %i %i\n"
        "After: [%i, %i, %i, %i]\n\n",
        inp + 0, inp + 1, inp + 2, inp + 3,
        opr + 0, opr + 1, opr + 2, opr + 3,
        out + 0, out + 1, out + 2, out + 3
    ) == 12) {
        // test operators
        cnt = 0;
        TEST( 0, RR,   +); TEST( 1, RI,   +); // add
        TEST( 2, RR,   *); TEST( 3, RI,   *); // mul
        TEST( 4, RR,   &); TEST( 5, RI,   &); // and
        TEST( 6, RR,   |); TEST( 7, RI,   |); // or
        TEST( 8, RR, +0*); TEST( 9, IR, +0*); // ass
        TEST(10, IR,   >); TEST(11, RI,   >); TEST(12, RR,  >); // gt
        TEST(13, IR,  ==); TEST(14, RI,  ==); TEST(15, RR, ==); // eq
        
        *ccalc |= opr[0] << 16; // store used opr id
        
        if(rem) {
            // apply found operators
            for(int i = 0; i < 16; i++) if(ops[i]) {
                if(i == opr[0]) *ccalc = 0;
                else *ccalc &= ~ops[i];
            }
            
            // check for unambiguous operator
            if(__builtin_popcount(*ccalc << 16 >> 16) == 1) {
                apply(*ccalc);
                *ccalc = 0;
            }
        }
        
        ccalc++; calcs++;
        if(cnt >= 3) ++pt1;
    }
    
    printf("Part 1: %i\n", pt1);
    
    // execute program

    #define EXEC(ID, TYPE, EXEC) case 1 << ID: inp[opr[3]] = CALC##TYPE(EXEC); break;
    inp[0] = inp[1] = inp[2] = inp[3] = 0;

    while(fscanf(f, "%i %i %i %i\n", opr + 0, opr + 1, opr + 2, opr + 3) == 4)
    {
        //printf("%i(%i) ", *opr, ops[*opr]);
        switch(ops[*opr])
        {
            EXEC( 0, RR,   +); EXEC( 1, RI,   +);
            EXEC( 2, RR,   *); EXEC( 3, RI,   *);
            EXEC( 4, RR,   &); EXEC( 5, RI,   &);
            EXEC( 6, RR,   |); EXEC( 7, RI,   |);
            EXEC( 8, RR, +0*); EXEC( 9, IR, +0*);
            EXEC(10, IR,   >); EXEC(11, RI,   >); EXEC(12, RR,  >);
            EXEC(13, IR,  ==); EXEC(14, RI,  ==); EXEC(15, RR, ==);
        }
    }
    
    printf("Part 2: %i\n", *inp);
    fclose(f);
    return 0;
}
