
#include <stdio.h>
#include <string.h>

char ini[] = "###.##.##.#.....###.##.#..........###.##.##.##.##.##.##.##.##.#......###.##.##.##.##.##.##.##.##.##.##.##.##.##.##.##.#.......###.##.##.##.#";

#define GEN 50000000000
#define OFF (GEN - 40)

int main() {
    long unsigned int sum = 0;
    unsigned int i, len = strlen(ini);
    for(i = 0; i < len; i++) sum += (ini[i] == '#') * (OFF + i);
    printf("sum: %lu\n", sum);
}

