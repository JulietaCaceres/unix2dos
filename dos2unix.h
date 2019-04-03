#ifndef __DOS2UNIX_H__
#define __DOS2UNIX_H__

#include <stdio.h>


typedef struct {
	FILE * _fin;
	FILE *_fout;
	char * _buff[50];
} Dos2unix_t;

int Dos2unix_create(Dos2unix_t *, FILE *, FILE *);

int Dos2unix_start(Dos2unix_t *);


#endif
