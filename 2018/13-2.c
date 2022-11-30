
// gcc 132.c -o 132.out && ./132.out

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#define WIDTH 150
#define HEIGHT 150

typedef struct { int x, y, dir, trn; } Cart;


const char
    *cdirs = ">v<^",   // L D R U
    *mdirs = "-|/\\+"; // H V Cl CCl

char map[HEIGHT][WIDTH] /*, cpy[HEIGHT][WIDTH]*/;
Cart cart[17];

int carts = 0, steps = 0;


int comp(const void* elem1, const void *elem2) {
    Cart a = *((Cart*)elem1);
    Cart b = *((Cart*)elem2);
    return (WIDTH * (a.y - b.y) > b.x - a.x) ? 1 : -1;
}

void swap(int a, int b) {
    Cart t = cart[a];
    cart[a] = cart[b];
    cart[b] = t;
}


int main() {
    int y = 0;
    char c, *cp, *mapp = map[0];
    FILE* f = fopen("13.txt", "r");
    
    // parse input
    while((c = fgetc(f)) != EOF) {
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
    
    int rem = carts;
    
    while(rem > 1) {
        /*/ anim
        for(y = 0; y < 40; y++) strncpy(cpy[y], map[y], 156);
        for(y = 0; y < rem; y++) if(cart[y].dir != -1) cpy[cart[y].y][cart[y].x] = cdirs[cart[y].dir];
        for(y = 0; y < 40; y++) printf("%.*s\n", 156, cpy[y]);
        getchar(); // usleep(50000);
        //*/
        
        qsort(cart, rem, sizeof(Cart), comp);
        
        steps++;
        for(y = 0; y < rem; y++)
        {
            if(cart[y].dir == -1) continue;
            c = strchr(mdirs, map[cart[y].y][cart[y].x]) - mdirs;
            
            // turn
            if(c > 1) {
                if(c < 4) cart[y].dir = 3 - (cart[y].dir + 2 * (c % 2)) % 4;
                else cart[y].dir = (3 + cart[y].dir + cart[y].trn++ % 3) % 4;
                c = cart[y].dir % 2;
            }
            
            // move
            if(c) cart[y].y += cart[y].dir == 1 ? 1 : -1;
            else  cart[y].x += cart[y].dir == 0 ? 1 : -1;
      
            // check collision
            for(c = 0; c < rem; c++)
                if(c != y && cart[c].dir != -1 && cart[y].x == cart[c].x && cart[y].y == cart[c].y) {
                    cart[y].dir = cart[c].dir = -1;
                    printf("%5i, %2i: %3i,%3i\n", steps, rem, cart[y].x, cart[y].y);
                }
        }
        
        for(c = 0; c < rem;)
            if(cart[c].dir == -1) swap(c, --rem);
            else c++;
    }
    
    printf("%5i, %2i: %3i,%3i\n", steps, rem, cart->x, cart->y);
    return 0;
}

