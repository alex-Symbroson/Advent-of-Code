//g++ -std=c++11 -O3 92.cpp -o 92.out && ./92.out

#include <stdio.h>
#include <stdlib.h>
#include <list>

#define players 400
#define marbles 7186400

int main() {

    uint score[players], cur = 0, tcur = 0, i, size;
    std::list<uint> marble = {0};
    std::list<uint>::iterator it = marble.begin(), tit;

    // reset score
    for(i = 0; i < players; i++) score[i] = 0;

    for(i = 1; i < marbles; i++) {
        size = marble.size();
        if(i % 23) {
            // rotate +2
            tcur = (cur + 2) % size;
            if(tcur <= cur) it = std::next(marble.begin(), tcur);
            else std::advance(it, 1);
            
            cur = tcur;
            // insert element
            marble.insert(it, i);
        } else {
            // rotate -7
            tcur = (cur + size - 7) % size;
            if(tcur >= cur) it = std::prev(marble.end(), size - tcur);
            else std::advance(it, -8);
            
            cur = tcur;
            score[i % players] += i + *it;
            
            // erase element
            std::advance(tit = it, 2);
            marble.erase(it);
            it = tit;
        }
    }
    
    // get maximum
    size = 0;
    for(i = 0; i < players; i++) if(size < score[i]) size = score[i];
    printf("%u\n", size);
}
