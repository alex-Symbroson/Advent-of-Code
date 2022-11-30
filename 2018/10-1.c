
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#define WIDTH  100
#define HEIGHT 20

typedef struct { int x, y, dx, dy; } Point;

int len, secs = 0;
Point *point, max = {100, 100, WIDTH, HEIGHT};

char field[HEIGHT][WIDTH];

int scale(int x, int sx, int sw, int dx, int dw) {
    return dw * (x-sx) / sw + dx;
}

#define isstar(x, y) (field[y][x] == '#')

int main()
{
    FILE* f = fopen("10.txt","r");
    point = (Point*)malloc((len = 100) * sizeof(Point));
    
    int i = 0;
    while(fscanf(f, "position=<%i,%i> velocity=<%i,%i>\n",
        &point[i].x, &point[i].y, &point[i].dx, &point[i].dy) == 4) {
        if(++i >= len) point = (Point*)realloc(point, (len *= len) * sizeof(Point));
    }
    fclose(f);
    point = (Point*)realloc(point, (len = i) * sizeof(Point));
    
    Point p;
    
    int pairs;
    while(1)
    {
        pairs = 0;
        
        for(int x = 0; x < WIDTH; x++)
        for(int y = 0; y < HEIGHT; y++)
        field[y][x] = ' ';
        
        for(i = 0; i < len; i++)
        {
            p.x = scale(point[i].x += point[i].dx, max.x, max.dx, 0, WIDTH);
            p.y = scale(point[i].y += point[i].dy, max.y, max.dy, 0, HEIGHT);

            if(p.x > 0 && p.x < WIDTH - 1 && p.y > 0 && p.y < HEIGHT - 1) {
                pairs +=
                    isstar(p.x + 1, p.y) + isstar(p.x - 1, p.y) + 
                    isstar(p.x, p.y + 1) + isstar(p.x, p.y - 1);
                field[p.y][p.x] = '#';
            }
        }

        secs++;

        if(pairs > 100) {
            for(int y = 0; y < HEIGHT; y++)
                printf("%.*s\n", WIDTH, field[y]);
            printf("-%6i secs-----------", secs);
            getchar();
        }
    }
    
    printf("\n");
    return 0;
}
