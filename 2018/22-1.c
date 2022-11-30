
// gcc 221.c -o 221.out && ./221.out

#include <stdio.h>
#include <stdint.h>
#include "bmp.h"

#define DEPTH 4845
#define TX 6
#define TY 770
#define WIDTH 80
#define HEIGHT 800
//>5393 <10603
int map[HEIGHT][WIDTH];

int getIndex(int x, int y) {
    if(x == TX && y == TY) return 0;
    if(x) {
        if(y) return (map[y][x - 1] * map[y - 1][x] + DEPTH) % 20183;
        else  return (x * 16807 + DEPTH) % 20183;
    } else return (y * 48271 + DEPTH) % 20183;
}

int main() {

    int w = WIDTH, h = HEIGHT;
    RGBTuple bmp[3][h][w];
    
    for(int y = 0; y < w; y++)
    for(int x = 0; x < h; x++)
    bmp[0][y][x] = bmp[1][y][x] = bmp[2][y][x] = MonoRGB(0);

    int risk = 0;
    for(int y = 0; y < HEIGHT; y++) {
        for(int x = 0; x < WIDTH; x++) {
            map[y][x] = getIndex(x, y);
            if(y <= TY && x <= TX) risk += map[y][x] % 3;
            bmp[0][y][x] = MonoRGB(255 * (map[y][x] % 3 != 0));
            bmp[1][y][x] = MonoRGB(255 * (map[y][x] % 3 != 1));
            bmp[2][y][x] = MonoRGB(255 * (map[y][x] % 3 != 2));
        }
    }
    
    bmp[0][TY][TX] = bmp[1][TY][TX] = bmp[2][TY][TX] = RGB(255, 0, 0);
    
    writeBMP("img0.bmp", w, h, bmp[0]);
    writeBMP("img1.bmp", w, h, bmp[1]);
    writeBMP("img2.bmp", w, h, bmp[2]);
    printf("risk: %i\n", risk);
}
