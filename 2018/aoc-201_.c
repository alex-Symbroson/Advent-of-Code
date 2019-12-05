
#include <stdio.h>

//3455
FILE* f;
int maxdist;
#define incdist() if(++dist > maxdist) maxdist = dist

void go(int x, int y, int dist) {
    int s[3] = {x, y, dist};
    while(1)
    switch(fgetc(f)) {
        case 'N': y--; incdist(); break;
        case 'E': x++; incdist(); break;
        case 'W': x--; incdist(); break;
        case 'S': y++; incdist(); break;
        case '(': go(x, y, dist); break;
        case '|': x = s[0]; y = s[1]; dist = s[2]; break;
        case ')':
        case '$':
        case EOF: return;
        default: fprintf(stderr, "ukn char!\n");
    }
}

int main() {
	if (!(f = fopen("200.txt", "r"))) {
		fprintf(stderr, "couldnt open file\n");
		return 1;
	}
	
	char c;
	while((c = fgetc(f)) != EOF)
    if(c == '^') {
        maxdist = 0;
        go(0, 0, 0);
        printf("maxdist: %i\n", maxdist);
    }
}
