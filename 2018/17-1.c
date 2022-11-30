
#include <stdio.h>
#include <unistd.h>
#include <string.h>

// map
#define SX 460
#define SW 80
#define SY 0
#define SH 1900

// view
#define VX 0
#define VY 0
#define VW 80
#define VH 55

// console
#define CW VW
#define CH VH

char map[SH][SW];
int sum = 0;

void printMap()
{
    static char buf[CH][CW] = {{0}};
    if(!**buf)
    for(int y = 0; y < CH; y++)
    for(int x = 0; x < CW; x++)
    buf[y][x] = ' ';
    
    for(int y = 0; y < VH; y++)
    for(int x = 0; x < VW; x++)
    if(map[VY + y][VX + x] != '.')
    buf[CH * y / VH][CW * x / VW] = map[VY + y][VX + x];
    
    for(int y = 0; y < 85; y++)
        printf("\n%.*s", CW, buf[y]);
    getchar();
    //usleep(60000);
}

void flow(int x, int y)
{
    printf("flow(%i,%i)\n",x,y);
    map[y][x] = '@';
    while(y < SH - 5 && map[y + 1][x] == '.') {
        sum++;
        map[++y][x] = '|';
    }
    if(y > 1815)
    printMap();
    if(y >= SH - 5) return;
    
    int i = x, flowing = 1;
    while(map[y + 1][i] != '@' && map[y + 1][i] != '.') i++;
    if(map[y + 1][i] == '@') return;
    
    i = x;
    while(map[y + 1][i] != '@' && map[y + 1][i] != '.') i--;
    if(map[y + 1][i] == '@') return;
    
    do {
        map[y][x] = '~';
        i = x + 1;
        while(map[y][i] != '#' && map[y + 1][i] != '.') map[y][i++] = '~';
        if(map[y + 1][i] == '.')
            flow(i, y), flowing = 0;
        
        i = x - 1;
        while(map[y][i] != '#' && map[y + 1][i] != '.') map[y][i--] = '~';
        if(map[y + 1][i] == '.')
            flow(i, y), flowing = 0;
    } while(y-- && flowing);
}

int main() {

	FILE *f = fopen("17.txt", "r");
	if (!f) {
		fprintf(stderr, "couldnt open file\n");
		return 1;
	}

	char c;
	int line[3], x, y;
    
    for (y = 0; y < SH; y++)
    for (x = 0; x < SW; x++)
    map[y][x] = '.';
    
	while ((c = fgetc(f)) != EOF)
    {
		if (c == 'x') {
			if (fscanf(f, "=%i, y=%i..%i\n", line + 0, line + 1, line + 2) != 3)
				break;
			
			for (y = line[1]; y <= line[2]; y++)
			    map[y][*line] = '#';
		
		}
        else if (c == 'y')
        {
			if (fscanf(f, "=%i, x=%i..%i\n", line + 0, line + 1, line + 2) != 3)
				break;
            
            for (x = line[1]; x < line[2]; x++)
			    map[*line][x] = '#';
			
		} else break;
	}
	
	flow(500, 0);
	
	printf("\n");
	return 1;
}
