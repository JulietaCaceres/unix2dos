#ifndef __UNIX2DOS_H__
#define __UNIX2DOS_H__

#include <stdio.h>


typedef struct {
	FILE * _fin;
	FILE *_fout;
	char * _buff[50];
} Unix2dos_t;

int Unix2dos_create(Unix2dos_t *, FILE *, FILE *);

int Unix2dos_start(Unix2dos_t *);


#endif
