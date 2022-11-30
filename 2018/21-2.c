
/*
4591209  :  10001100000111001101001
65899    :        10000000101101011
16777215 : 111111111111111111111111
*/

#include <stdio.h>

int main() {
	int r0 = 0, r1, r5, cnt, max = 0;
start:
	r1 = 0;r5 = 0;cnt = 0;

    do {
	    r1 = r5 | 65536;
        r5 = ((4591209 + (r1 & 255)) * 65899) & 16777215;
        
        while(256 <= r1) {
            r1 /= 256;
            r5 = ((r5 + (r1 & 255)) * 65899) & 16777215;
            printf("r5 = %i\n", r5);
        }
        if(++cnt > 1e6) {
            ++r0;
            goto start;
        }
    } while (r5 != r0);
    
	if(max < cnt) printf("\033[1;31mr0 = %i; cnt = %i r5 = %i\033[0;37m\n", r0, max = cnt, r5);
	else printf("r0 = %i; cnt = %i\n", r0, cnt);
    ++r0;
	goto start;
}

