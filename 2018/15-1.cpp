
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <vector>

using namespace std;

class Pos {
public:
    int x, y;
    Pos(int _x, int _y) : x(_x), y(_y) {};
};
class Obj : Pos {
public:
    char type; int hp;
    Obj(char _type, int _x, int _y, int _hp = 200) : type(_type), Pos(_x, _y), hp(_hp) {};
};

#define WIDTH 50
#define HEIGHT 50
#define MAX 50
#define OBJ(t,x,y) (Obj){t, x, y, 200}

////////////////////////////////////////////////////////////////////////////////

char map[HEIGHT][WIDTH];

vector<Obj> gob, elf, availG, availE;
vector<Obj*> obj;

int width = 0, height = 0;

////////////////////////////////////////////////////////////////////////////////

void pushObj(char type, Obj o) { auto& lst = (type == 'G' ? gob : elf); lst.push_back(o); obj.push_Back(&lst.back()); }
void pushAvail(char type, Obj o, int dx, int dy) { o.x += dx; o.y += dy; (type == 'G' ? availG : availE).push_back(o); }
//void swap(int a, int b) { Obj* t = obj[a]; obj[a] = obj[b]; obj[b] = t; }
int comp(const void* pa, const void *pb) {
    Obj* a = *((Obj**)pa), b = *((Obj**)pb);
    return (WIDTH * (a->y - b->y) > b->x - a->x) ? 1 : -1;
}

void printObjs() {
    printf("----------------------\n" "Elfs       |Goblins\n" "-----------+----------\n" "  x  y  hp |  x  y  hp\n");
    for(int i = 0; i < gobs || i < elfs; i++) {
        if(i >= elfs) printf("           |");
        else printf("%3i%3i%4i |", elf[i].x, elf[i].y, elf[i].hp);
        if(i >= gobs) printf("\n");
        else printf("%3i%3i%4i\n", gob[i].x, gob[i].y, gob[i].hp);
    }
}

void printField(int avail) {
    static char cpy[height][width];
    int y;
    for(y = 0; y < height; y++) strncpy(cpy[y], map[y], width);
    for(Obj& o : gobs) if(o.hp) cpy[o.y][o.x] = o.type;
    for(Obj& o : elfs) if(o.hp) cpy[o.y][o.x] = o.type;
    for(y = 0; y < height; y++) printf("%.*s\n", width, cpy[y]);
    getchar(); // usleep(50000);
}

int main() {
    FILE* f = fopen("150.txt", "r");
    if(!f) { fprintf(stderr, "couldn't open file\n"); return 1; }
    
////////////////////////////////////////////////////////////////////////////////

    int y = 0;
    char c, *cp, *mapp = map[0];
    
    // parse input
    while((c = fgetc(f)) != EOF) {
        switch(c) {
            case '\n':
                if(mapp - map[y] > width) width = mapp - map[y];
                mapp = map[++y]; continue;
            case '#': case '.': *mapp = c; break;
            case 'G': case 'E':
                pushObj(*mapp = c, OBJ(c, mapp - map[y], y));
            break;
            default: fprintf(stderr, "ukn %c\n", c); return 1;
        }
        mapp++;
    }
    height = y;
    fclose(f);
    
////////////////////////////////////////////////////////////////////////////////
    
    int availGC, availEC;
    Obj availG[availGC = 4 * gobs],
        availE[availEC = 4 * elfs];
        
    qsort(obj, objs, sizeof(Obj*), comp);
    printObjs();
    printField();
    
    #define OBJT(i) obj[i]->type
    #define OBJX(i) obj[i]->x
    #define OBJY(i) obj[i]->y
    #define OBJHP(i) obj[i]->hp
    
    for(int i = 0; i < objs; i++) {
        int x = OBJX(i), y = OBJY(i);
        char* pos = field[y] + x;
        if(pos[-1] == '.') pushAvail(*obj[i], -1, 0);
        if(pos[+1] == '.') pushAvail(*obj[i], +1, 0);
        if(field[y - 1][x] == '.') pushAvail(*obj[i], 0, -1);
        if(field[y + 1][x] == '.') pushAvail(*obj[i], 0, +1);
    }
}


