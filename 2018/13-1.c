
// gcc 131.c -o 131.out && ./131.out

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define WIDTH 150
#define HEIGHT 150
#define MAPC(i) map[cart[i].y][cart[i].x]

typedef struct { int x, y, dir, trn; } Cart;

const char
    *cdirs = ">v<^",   // L D R U 0 1 2 3
    *mdirs = "-|/\\+"; // H V Cl CCl 0 1 2 3

char map[HEIGHT][WIDTH], cpy[HEIGHT][WIDTH];
Cart cart[17];

int carts = 0;

int comp(const void* elem1, const void *elem2) {
    Cart a = *((Cart*)elem1);
    Cart b = *((Cart*)elem2);
    return (WIDTH * (a.y - b.y) > b.x - a.x) ? 1 : -1;
}

int main()
{
    int y = 0;
    char c, *cp, *mapp = map[0];
    FILE* f = fopen("13.txt", "r");
    
    // parse input
    while((c = fgetc(f)) != EOF)
    {
        if(c == '\n') {
            mapp = map[++y];
            continue;
        }
        
        if(cp = strchr(cdirs, c)) {
            cart[carts++] = (Cart){ mapp - map[y], y, cp - cdirs, 0 };
            *mapp = "-|"[(cp - cdirs) % 2];
        } else *mapp = c;
        mapp++;
    }
    fclose(f);
    
    while(1) {
        /* anim
        for(y = 0; y < 7; y++) strncpy(cpy[y], map[y], 156);
        for(y = 0; y < carts; y++) cpy[cart[y].y][cart[y].x] = cdirs[cart[y].dir];
        for(y = 0; y < 7; y++) printf("%.*s\n", 156, cpy[y]);
        getchar();
        //*/
        
        for(y = 0; y < carts; y++) {
            c = strchr(mdirs, MAPC(y)) - mdirs;
        
        move:
            switch(c) {
                case 0: cart[y].x += cart[y].dir == 0? 1 : -1; break;
                case 1: cart[y].y += cart[y].dir == 1? 1 : -1; break;
                case 2: // '/' 0-3 1-2
                case 3: // '\' 1-0 2-3
                    cart[y].dir = 3 - (cart[y].dir + 2 * (c % 2)) % 4;
                case 4: // '+'
                    if(c == 4) cart[y].dir = (cart[y].dir + "301"[cart[y].trn++ % 3] - '0')%4;
                    c = cart[y].dir % 2;
                    goto move;
            }

            // check collision
            for(c = 0; c < carts; c++)
                if(c != y && cart[y].x == cart[c].x && cart[y].y == cart[c].y) {
                    printf("%i,%i :%i\n", cart[y].x, cart[y].y, carts);
                    return 0;
                }
        }
        qsort(cart, 17, sizeof(Cart), comp);
    }
}

