
// gcc 82.c -o 82.out && ./82.out

#include <stdio.h>
#include <stdlib.h>

int getMetadata(FILE* f) {
    int nodes, metas;
    
    // read amount of nodes and metadata
    if(fscanf(f, "%i %i", &nodes, &metas) != 2) goto error;
    else {
        int meta, i, sum = 0, sums[nodes];
        
        // process and store nodes in sums
        for(i = 0; i < nodes; i++) sums[i] = getMetadata(f);
        
        // process metadata
        for(i = 0; i < metas; i++)
            if(fscanf(f, "%i", &meta) != 1) goto error;
            else if(!nodes) sum += meta;
            else if(meta - 1 < nodes) sum += sums[meta - 1];
        
        return sum;
    }
    
error:
    fprintf(stderr, "unexpected eof\n");
    exit(1);
}

int main(int argc, char* argv[]) {
    FILE* f = fopen(argc == 1 ? "08.txt" : argv[1], "r");
    printf("%i\n", getMetadata(f));
    fclose(f);
    return 0;
}

