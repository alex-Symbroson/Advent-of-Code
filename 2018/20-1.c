
#include <stdio.h>
#include <unistd.h>

#define SX 105
#define SY 105
#define SW 201
#define SH 201

typedef struct { char type; int dist; } Field;

FILE* f;
Field map[1000][1000];

#define TMAP(X, Y) map[SY + Y][SX + X].type
#define DMAP(X, Y) map[SY + Y][SX + X].dist

int maxdist, roomcnt;

//#define CHKDIST() if(++dist > maxdist) maxdist = dist

//#define CHKDIST() ++dist; \
    if(!DMAP(x,y) && maxdist < (DMAP(x,y) = dist)) maxdist = dist;

#define CHKDIST() ++dist; \
    if(!DMAP(x,y) && (DMAP(x,y) = dist) >= 1000) ++roomcnt;

void go(int x, int y, int dist) {
    int s[3] = {x, y, dist};
    while(1) {
        
        switch(fgetc(f)) {
            case 'N': TMAP(x, --y) = '-'; TMAP(x, --y) = '.'; CHKDIST(); break;
            case 'E': TMAP(++x, y) = '|'; TMAP(++x, y) = '.'; CHKDIST(); break;
            case 'W': TMAP(--x, y) = '|'; TMAP(--x, y) = '.'; CHKDIST(); break;
            case 'S': TMAP(x, ++y) = '-'; TMAP(x, ++y) = '.'; CHKDIST(); break;
            case '(': go(x, y, dist); break;
            case '|': x = s[0]; y = s[1]; dist = s[2]; break;
            case ')': 
            case '$': 
            case EOF: return;
            default: fprintf(stderr, "ukn char!\n");
        }
        
        if(1 && (y > 0 ? y : -y) < 14 / 2) {
            printf("\033[1;1Hmaxdist: %i\n", maxdist);
            /*
            char buf[SW];
            for(int ty = SW / 2 - 14 / 2; ty < SW / 2 + 14 / 2; ty++) {
                for(int tx = 0; tx < SW; tx++)
                    buf[tx] = map[ty][tx].type;
                if(ty == SY + y) buf[SX + x] = 'X';
                printf("%.*s\n", SW, buf);
            }
            */
            for(int y = SH/2-20; y < SH/2+20; y++) {
                for(int x = SW/2-20; x < SW/2+20; x++)
                    printf("%c", map[y][x].type);
                printf("\n");
            }

            getchar(); //usleep(1000);
        }
    }
}

int main() {
	if (!(f = fopen("20.txt", "r"))) {
		fprintf(stderr, "couldnt open file\n");
		return 1;
	}
	
	char c, n = 0;
	while((c = fgetc(f)) != EOF)
    if(c == '^' && ++n) {
        for(int y = 0; y < SH; y++)
        for(int x = 0; x < SW; x++)
        map[y][x] = (Field){'#', 0};
        TMAP(0, 0) = 'X';
        
        maxdist = roomcnt = 0;
        go(0, 0, 0);
        
        for(int y = 0; y < SH; y++) {
            for(int x = 0; x < SW; x++)
                printf("%c", map[y][x].type);
            printf("\n");
        }
        
        printf("\nmaxdist: %i\nroomcnt: %i\n", maxdist, roomcnt);
    }
}
