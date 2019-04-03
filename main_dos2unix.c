#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <getopt.h>
#include <stdbool.h>
#include <unistd.h>
#include "dos2unix.h"
FILE * open_infile(const char * path) {
    return fopen(path, "rb");
}

FILE * open_outfile(const char * path) {
    return fopen(path, "wt");
}

int main (int argc, char ** argv) {

    FILE * fin = NULL;   // Default is stdin
    FILE * fout = NULL; // Default is stdout
    int c;
    static struct option long_options[] = {
		{"input", optional_argument, 0, 'i'},
		{"output", optional_argument, 0, 'o'},
		{0, 0, 0, 0}
	};

    int option_index = 0;
	while ((c = getopt_long(argc, argv, "i:o:a:", long_options, &option_index)) != -1) {
		switch (c) {
			case 'i':
				if (strcmp(optarg, "-") != 0) {
					fin = open_infile(optarg);
					if (!fin) {
						fprintf(stderr, "Can not open input file '%s'\n", optarg);
						return EXIT_FAILURE;
					}
				}
				
				break;

			case 'o':
				if (strcmp(optarg, "-") != 0) {
					fout = open_outfile(optarg);
					if (!fout) {
						fprintf(stderr, "Can not open output file '%s'\n", optarg);
						return EXIT_FAILURE;
					}
				}
				break;

			default:
				fprintf(stderr, "Unknown option '%c'\n", c);
				return EXIT_FAILURE;
		}
	}

	//printf("tenemos los archivos");
// Dejo comentado que haria si no usara los arhivos unix2dos
//	int character;
//	do {
//		character = fgetc (fin);
//		if(character == '\n') {
//			printf("un barra n");
//			fputc('\r', fout);
//			fputc(character, fout);
//		}else {
//			printf("The integer is %c \n",(char)character);
//			fputc(character, fout);
//		}
//	}while (character != EOF);

	Dos2unix_t dos2unix;
	Dos2unix_create(&dos2unix, fin, fout);
	Dos2unix_start(&dos2unix);

	if (fin) {
		fclose(fin);
	}
	if (fout) {
		fclose(fout);
	}

	if (!fout) {
		// Si la salida es estandar
		// imprimimos un \n final
		// puts("");
	}

	return EXIT_SUCCESS;
}
