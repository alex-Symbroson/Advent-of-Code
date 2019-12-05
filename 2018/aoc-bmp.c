
#include <stdio.h>

typedef unsigned char uchar;

typedef struct { uchar b, g, r; } RGBTuple;
#define RGB(r, g, b) (RGBTuple){b, g, r}

uchar min(uchar a, uchar b) { return a < b ? a : b; }

void writeBMP(const char* name, int w, int h, RGBTuple bmp[h][w]) {
    FILE *f;
    int filesize = 54 + 3 * w * h;

    uchar bmpfileheader[14] = {
        'B','M',
        filesize >>  0, filesize >>  8,
        filesize >> 16, filesize >> 24,
        0,0, 0,0, 54,0,0,0
    };

    uchar bmpinfoheader[40] = {
        40,0,0,0, // header size
        w >> 0, w >> 8, w >> 16, w >> 24, // width
        h >> 0, h >> 8, h >> 16, h >> 24, // height
        1,0,     // color planes
        24,0,    // bits per pixel
        0,0,0,0, // compression
        0,0,0,0, // image size
        0,0,0,0, // horizontal resolution
        0,0,0,0, // vertical resolution
        0,0,0,0, // colors in color table
        0,0,0,0, // important color count
    };
    
    uchar bmppad[3] = {0, 0, 0};

    f = fopen(name, "wb");
    fwrite(bmpfileheader, 1, 14, f);
    fwrite(bmpinfoheader, 1, 40, f);

    for(int i = 0; i < h; i++) {
        fwrite(bmp[h - i], 3, w, f);
        fwrite(bmppad, 1, (4 - (w * 3) % 4) % 4, f);
    }

    fclose(f);
}

