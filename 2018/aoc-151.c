
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Obj Obj_t;
typedef struct { int x, y; } Pos;
typedef struct { char type; int x, y, hp; Obj_t* avail; } Obj;
typedef struct { char type; int visited; } Field;

#define WIDTH 50
#define HEIGHT 50
#define MAX 50
#define OBJ(t,x,y) (Obj){t, x, y, 200}

////////////////////////////////////////////////////////////////////////////////

Field map[HEIGHT][WIDTH];

Obj gob[MAX], elf[MAX], *obj[2 * MAX],
    *availG, *availE;

int width   = 0, height  = 0,
    gobs    = 0, elfs    = 0, objs = 0,
    availGC = 0, availEC = 0;

char enemy, dirs;

////////////////////////////////////////////////////////////////////////////////

Obj* getObj(char type) { return type == 'G' ? gob + gobs : elf + elfs; }
Obj* getAvail(char type) { return type == 'G' ? availG + availGC : availE + availEC; }
void pushObj(char type, Obj o) { *(obj[objs++] = type == 'G' ? gob + gobs++ : elf + elfs++) = o; }
void pushAvail(Obj o, int dx, int dy) { o.x += dx; o.y += dy; *(o.type == 'G' ? availG + availGC++ : availE + availEC++) = o; }
void swap(int a, int b) { Obj* t = obj[a]; obj[a] = obj[b]; obj[b] = t; }
int comp(const void* pa, const void *pb) {
    Obj *a = *((Obj**)pa), *b = *((Obj**)pb);
    return (WIDTH * (a->y - b->y) > b->x - a->x) ? 1 : -1;
}

void printObjs() {
    printf("----------------------\n" "Elfs       |gobs\n" "-----------+----------\n" "  x  y  hp |  x  y  hp\n");
    for(int i = 0; i < gobs || i < elfs; i++) {
        if(i >= elfs) printf("           |");
        else printf("%3i%3i%4i |", elf[i].x, elf[i].y, elf[i].hp);
        if(i >= gobs) printf("\n");
        else printf("%3i%3i%4i\n", gob[i].x, gob[i].y, gob[i].hp);
    }
}

void printMap(int avail) {
    static char cpy[HEIGHT][WIDTH];
    int x, y;
    for(y = 0; y < height; y++) for(x = 0; x < width; x++)  cpy[y][x] = map[y][x].type;
    //for(y = 0; y < gobs; y++) if(gob[y].hp) cpy[gob[y].y][gob[y].x] = gob[y].type;
    //for(y = 0; y < elfs; y++) if(elf[y].hp) cpy[elf[y].y][elf[y].x] = elf[y].type;
    if(avail) for(y = 0; y < availGC; y++) cpy[availG[y].y][availG[y].x] = '?';
    if(avail) for(y = 0; y < availEC; y++) cpy[availE[y].y][availE[y].x] = '?';
    for(y = 0; y < height; y++) printf("%.*s\n", width, cpy[y]);
    getchar(); // usleep(50000);
}

int main() {
    FILE* f = fopen("150.txt", "r");
    if(!f) { fprintf(stderr, "couldn't open file\n"); return 1; }
    
////////////////////////////////////////////////////////////////////////////////

    int y = 0;
    Field *mapp = map[0];
    
    // parse input
    while((c = fgetc(f)) != EOF) {
        switch(c) {
            case '\n':
                if(mapp - map[y] > width) width = mapp - map[y];
                mapp = map[++y]; continue;
            case '#': case '.': mapp->type = c; break;
            case 'G': case 'E':
                pushObj(mapp->type = c, OBJ(c, mapp - map[y], y));
            break;
            default: fprintf(stderr, "ukn %c\n", c); return 1;
        }
        mapp++;
    }
    height = y;
    fclose(f);
    
////////////////////////////////////////////////////////////////////////////////
    
    Obj _availG[availGC = 4 * gobs],
        _availE[availEC = 4 * elfs];
    availG = _availG; availE = _availE;
    
    Pos visit[width * height];
    int availC;
    
    qsort(obj, objs, sizeof(Obj*), comp);
    printObjs();
    printMap(0);
    
    #define OBJT(i) obj[i]->type
    #define OBJX(i) obj[i]->x
    #define OBJY(i) obj[i]->y
    #define OBJH(i) obj[i]->hp
    #define OBJA(i) obj[i]->hp
    #define MAPT(x,y) map[y][x].type
    #define MAPV(x,y) map[y][x].visited
    
    // get available fields
    availGC = availEC = 0;
    for(int i = 0; i < objs; i++) {
        int x = OBJX(i), y = OBJY(i);
        OBJA(i) = getAvail(OBJT(i));
        
        if(MAPT(x - 1, y) == '.') pushAvail(*obj[i], -1, 0);
        if(MAPT(x + 1, y) == '.') pushAvail(*obj[i], +1, 0);
        if(MAPT(x, y - 1) == '.') pushAvail(*obj[i], 0, -1);
        if(MAPT(x, y + 1) == '.') pushAvail(*obj[i], 0, +1);
    }
    printMap(1);
    
    
    // process (reachable, nearest, move) players
    for(int i = 0; i < objs; i++) {
        int x = OBJX(i), y = OBJY(i);
        enemy = OBJT(i) == 'G'? 'E' : 'G';
        // reset visited
        dirs = 0;
        
        while(!found) {
            for()
        }
    }
    
}

#define TEXT(x, y, dir) \
    if(MAPT(x, y) == '.') return move(x, y); \
    if(MAPT(x, y) == enemy) dirs |= 1 << dir; \
    return dir;

int move(x, y) {
    MAPV(x, y) = 1;
    TEST(x, y - 1, 0); // u
    TEST(x, y + 1, 1); // d
    TEST(x - 1, y, 2); // l
    TEST(x + 1, y, 3); // r
}


