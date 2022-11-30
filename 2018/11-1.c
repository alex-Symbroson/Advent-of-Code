
#include <stdio.h>

#define GSN 18

int field[300][300];

int main() {
    int x, y, mx, my, s, v, max = 0;
    for(x = 0; x < 300; x++)
    for(y = 0; y < 300; y++)
    field[y][x] = (((x + 11) * y + GSN) * (x + 11) / 100) % 10 - 5;
    
    for(x = 0; x < 300; x++)
    for(y = 0; y < 300; y++)
    for(s = 2; s <= 300; s++)
        if(x + s < 300 && y + s < 300) {
            v = 0;
            for(mx = 0; mx < s; mx++)
            for(my = 0; my < s; my++)
                v += field[y + my][x + mx];

            if(v > max) printf("%i,%i,%i: %i\n", x + 1, y, s, max = v);
        }
}
