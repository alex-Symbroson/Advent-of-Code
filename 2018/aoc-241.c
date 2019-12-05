
// gcc 241.c -o 241.out && ./241.out

#include <stdio.h>
#include <string.h>
#include <stdint.h>

#define TIMM 0
#define TINF 1

typedef struct {
    int count, ihp, hp, ini, dmg, team, target;
    char weak[5], immune[5], type;
} Group;

Group imm[2], inf[2], *all[4];
int immc = 0, infc = 0, allc = 0;

int scanGroups(FILE* f, Group* group, int team) {

    if(fscanf(f,
        "%i groups each with %i hit points (", &group->count, &group->ihp
    ) != 2) return 1;
    group->hp = group->ihp;
    group->team = team;
    
    char *cp, buf[64];
    
    *buf = fgetc(f);
    if(*buf == 'i') {
        cp = group->immune;
        if(fscanf(f, "mmune to") == 0) {
            do {
                if(fscanf(f, " %s,", buf) != 1) break;
                *cp++ = *buf;
            } while((*buf = buf[strlen(buf) - 1]) == ',');
            if(*buf == ';') fgetc(f), *buf = fgetc(f);
        }
        *cp = 0;
    }
    
    if(*buf == 'w') {
        cp = group->weak;
        if(fscanf(f, "eak to") == 0) {
            do {
                if(fscanf(f, " %s", buf) != 1) break;
                *cp++ = *buf;
            } while(buf[strlen(buf) - 1] == ',');
        }
        *cp = 0;
    }
    
    if(fscanf(f,
        " with an attack that does %i %s damage at initiative %i\n",
        &group->dmg, buf, &group->ini) != 3
    ) return 1;
    group->type = *buf;
    
    printf(
        "cnt:%6i, hp:%6i, ini:%6i, dmg:%6i, type:%c, immune: %s, weak: %s\n",
        group->count, group->ihp, group->ini, group->dmg, group->type, group->immune, group->weak);
    
    return 0;
}

int calcdmg(Group *att, Group *dfn) {
    int dmg = 0;
    if(strchr(dfn->weak, att.type)) dmg = att->cnt * att
}

int compTSel(const void* pa, const void *pb) {
    Group *a = *((Group**)pa), *b = *((Group**)pb);
    int diff = a->cnt * a.dmg - b->cnt * b.dmg;
    if(!diff) diff = a->ini - b->ini;
    return diff > 0 ? : 1 : -1;
}

int main() {
    FILE* f = fopen("240.txt", "r");
    
    if(!f) {
        fprintf(stderr, "couldn't open file\n");
        return 1;
    }
    
    if(fscanf(f, "Immune System:\n") == 0)
        while(!scanGroups(f, all[allc++] = imm + immc++, 0));
    
    if(fscanf(f, "Infection:\n") == 0)
        while(!scanGroups(f, all[allc++] = inf + infc++, 1));
    
    allc = immc + infc;
    fclose(f);
    
    qsort(all, allc, sizeof(Group*), compTSel);
    for(int i = 0; i < allc; i++) {
        int max = 0, maxi = 0, oppc = all[j].team == TINF ? immc : infc;
        for(int j = 0; j < oppc; j++)
            if()
    }
}
