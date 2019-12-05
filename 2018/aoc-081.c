
// gcc 81.c -o 81.out && ./81.out

#include <stdio.h>
#include <stdlib.h>

int sum = 0;

void getMetadata(FILE* f) {
    int nodes, metas, i;
    
    // read amount of nodes and metadata
    if(fscanf(f, "%i %i", &nodes, &metas) != 2) goto error;
    
    // process nodes
    for(i = 0; i < nodes; i++) getMetadata(f);
    
    // process metadata (nodes reused for metadata)
    for(i = 0; i < metas; i++)
        if(fscanf(f, "%i", &nodes) != 1) goto error;
        else sum += nodes;
    
    return;
    
error:
    fprintf(stderr, "unexpected eof\n");
    exit(1);
}

int main(int argc, char* argv[]) {
    FILE* f = fopen(argc == 1 ? "80.txt" : argv[1], "r");
    getMetadata(f);
    printf("%i\n", sum);
    fclose(f);
    return 0;
}

