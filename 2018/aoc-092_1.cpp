
#include <stdio.h>
#include <stdlib.h>
#include <deque>

const uint
    players = 400,
    marbles = 7186400;

uint score[players], cur = 0;
std::deque<uint> marble = {0};
#define D(...) //__VA_ARGS__

int main() {
    uint i, n, max;

    for(i = 0; i < players; i++) score[i] = 0;

    for(i = 1; i <= marbles; i++) {
        if(!(i % 23)) {
            //printf("cur:%3i  size:%3i ", cur, marble.size());
            cur = (cur + marble.size() - 7) % marble.size();
            score[i % players] += i + marble[cur];
            //printf("erase:%3i\n", cur);
            marble.erase(marble.begin() + cur);
        } else {
            cur = (cur + 2) % marble.size();
            marble.insert(marble.begin() + cur, i);
        }

        D(
        printf("%i: ",i);
        for(n = 0; n < marble.size(); n++) printf("%i,",marble[n]);
        printf("\n");
        )
        if((100 * i) % marbles == 0) printf("%i%%\n",100 * i / marbles);
        /*
        if(!(i%23)) {
            var max = 0;
            for(var n = 0; n <= score.length; n++) if(max < score[n]) max = score[n];
            console.log(i + ": " + max);
         }*/
        //if(i%71864==0)console.log(i/71864);
    }
    
    max = 0;
    for(i = 0; i < players; i++) if(max < score[i]) max = score[i];
    printf("%i\n",max);
}
