
#include <stdio.h>
#include <string.h>

#define RULES 32
#define OFF -5
#define INIT ".##..#.#..##..##..##...#####.#.....#..#..##.###.#.####......#.......#..###.#.#.##.#.#.###...##.###.#"
#define DOTS ".............................."

char ini[] = "....." INIT DOTS DOTS DOTS DOTS DOTS DOTS "\0",
    next[] = "....." INIT DOTS DOTS DOTS DOTS DOTS DOTS "\0",
    *rules[RULES] = {
    
        //*
        ".##.# => #", "##.#. => #",
        "##... => #", "#.... => .",
        ".#..# => .", "#.##. => .",
        ".##.. => .", ".#.## => .",
        "###.. => .", "..##. => #",
        "##### => #", "#...# => #",
        ".#... => #", "###.# => #",
        "#.### => #", "##..# => .",
        ".###. => #", "...## => .",
        "..#.# => .", "##.## => #",
        "....# => .", "#.#.# => #",
        "#.#.. => .", ".#### => .",
        "...#. => #", "..### => .",
        "..#.. => #", "..... => .",
        "####. => .", "#..## => #",
        ".#.#. => .", "#..#. => #"
        //*/
    };

int main() {
    int sum, r, i, len = strlen(ini);
    printf("%.*s\n", len, next);
    
    for(int n = 0; n < 1000; n++) {
        for(i = 0; i < len - 5; i++) {
            for(r = 0; r < RULES; r++)
                if(!strncmp(rules[r], ini + i, 5)) {
                    //printf("%s\n", rules[r]);
                    next[i + 2] = rules[r][9];
                    break;
                }
            if(r == RULES) next[i + 2] = '.';
        }
        
        sum = 0;
        for(i = 0; i < len; i++)
            sum += ((ini[i] = next[i]) == '#' ? 1 : 0) * (OFF + i);

        printf("%i: %i\n%.*s\n", n + 1, sum, len, next);
    }
    
}
