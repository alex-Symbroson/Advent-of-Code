
#include <math.h>
#include <stdio.h>
#include <string.h>

#define dig(num, i) ((num) / (int)pow(10, i) % 10)
#define incd(num, i, n) ((num) += (n)*pow(10, (i)))

int main() {
    int beg = 197487, end = 673251;

    while (beg < end) {
        // validify
        for (int i = 4; i--;)
            if (dig(beg, i + 1) > dig(beg, i))
                incd(beg, i, dig(beg, i + 1) - dig(beg, i));

        printf("%i", beg);
        break;
    }
}
