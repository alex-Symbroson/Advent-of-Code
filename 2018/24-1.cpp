
// gcc 241.c -o 241.out && ./241.out

#include <stdio.h>
#include <string.h>
#include <stdint.h>

typedef struct {
    int count, ihp, hp, ini, dmg;
    char weak[5], immune[5], type;
} Unit;

Unit imm[2], inf[2];
int immc = 0, infc = 0;

int main() {
    FILE* f = fopen("24.txt", "r");
    
    if(!f) {
        fprintf(stderr, "couldn't open file\n");
        return 1;
    }
    
    Unit unit;
    int cnt;
    char *weak, *type;
    if(fscanf(f, "Immune System:\n") == 0) {
        printf("1\n");
        if((cnt = fscanf(f,
            "%i units each with %i hit points (%[A-Za-z ,;]) with an "
            "attack that does %i %s damage at initiative %i\n",
            &unit.count, &unit.ihp, weak, &unit.dmg, type, &unit.ini
        )) == 6) {
            unit.type = *type;
            unit.hp = unit.ihp;
            
            printf("2 %s\n", weak);
            char* cp = unit.immune;
            if(sscanf(weak, "immune to") == 0) {
                do {
            printf("21\n");
                    if(sscanf(weak, " %s", weak) != 1) return 1;
            printf("22\n");
                    *cp++ = *weak;
            printf("23\n");
                } while(fgetc(f) == ',');
                *cp = 0;
            }
            
            printf("3\n");
            cp = unit.weak;
            if(sscanf(weak, " weak to") == 0) {
                do {
                    if(sscanf(weak, " %s", weak) != 1) return 1;
                    *cp++ = *weak;
                } while(fgetc(f) == ',');
                *cp = 0;
            }
            
            printf(
                "cnt:%6i, hp:%6i, ini:%6i, dmg:%6i, type:%c, immune: %s, weak: %s\n",
                unit.count, unit.ihp, unit.ini, unit.dmg, unit.type, unit.immune, unit.weak);
        }
    }
    printf("scanned %i\n", cnt);
    fclose(f);
}
