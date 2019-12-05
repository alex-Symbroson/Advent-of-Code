
#include <stdio.h>
#include <unistd.h>
#include <string.h>

#define SX 1
#define SY 1
#define SW 50
#define SH 50

#define IN1 10
#define IN2 1000000000

char map[SH + 2][SW + 2],
    tmap[SH + 2][SW + 2];

void print() {
    char buf[SW];
    for (int y = SY; y <= SH; y++) {
        for (int x = 0; x < SW; x++)
            buf[x] = ".|#"[map[y][SX + x + 1]];
        printf("\n%.*s", SW, buf);
    }
}

int score() {
    int c = 0, i = 0;
    for (int y = SY; y <= SH; y++)
    for (int x = SX; x <= SW; x++)
        if(map[y][x] == 1) c++;
        else if(map[y][x] == 2) i++;
    return c * i;
}

int main() {
    
    FILE *f = fopen("180.txt", "r");
    if (!f) {
        fprintf(stderr, "couldnt open file\n");
        return 1;
    }
    
    int c, x = 1, y = 1, i;
    
    for (i = 0; i < SW + 2; i++) {
        map[0][i] = map[SH + 1][i] =
        map[i][0] = map[i][SW + 1] = 0;
    }
    
    while ((c = fgetc(f)) != EOF) {
        if(c == '\n') y++, x = 0;
        else map[y][x++] = (c == '|') + 2 * (c == '#');
    }
    
    #define CNT(c) cnt[c]++
    i = 0;
    print();
    getchar();
    while(++i) {
        for (y = 0; y < SH + 2; y++)
            memcpy(tmap[y], map[y], SW + 2);
        
        for (y = SY; y <= SH; y++)
        for (x = SX; x <= SW; x++) {
            int cnt[3] = {0, 0, 0};
            
            CNT(tmap[y][x - 1]);
            CNT(tmap[y][x + 1]);
            CNT(tmap[y - 1][x]);
            CNT(tmap[y + 1][x]);
            
            CNT(tmap[y - 1][x - 1]);
            CNT(tmap[y - 1][x + 1]);
            CNT(tmap[y + 1][x - 1]);
            CNT(tmap[y + 1][x + 1]);
            
            if(tmap[y][x] == 2) {
                if (!cnt[1] || !cnt[2]) map[y][x] = 0;
            } else if (cnt[tmap[y][x] + 1] > 2) map[y][x]++;
        }
        
        print();
        usleep(100000);
        continue;
        if(i == IN1 || (i > 500 && i % 28 == IN2 % 28)) {
            printf("Part %i: time: %3i min; score: %i\n",
                1 + (i != IN1), i, score());
            if(i != IN1) return 0;
        }
    }
}

