
/*
4591209  :  10001100000111001101001
65899    :        10000000101101011
16777215 : 111111111111111111111111
*/

#include <stdio.h>

int main() {
	int r0 = 0, r1, r5, cnt, min = 1e5;
start:
	r1 = 0;r5 = 0;cnt = 0;

    do {
	    r1 = r5 | 65536;
        r5 = ((4591209 + (r1 & 255)) * 65899) & 16777215;
        
        while(256 <= r1) {
            r1 /= 256;
            r5 = ((r5 + (r1 & 255)) * 65899) & 16777215;
        }
        
        if(++cnt > min) {
            ++r0;
            goto start;
        }
    } while (r5 != r0);
	
	if(!min || min > cnt) printf("r0 = %i; cnt = %i\n", r0++, min = cnt);
	if(min > 1) goto start;
}

