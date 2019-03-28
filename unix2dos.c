#include <string.h>
#include <arpa/inet.h>
#include "unix2dos.h"
#include <stdio.h>


//Esta función inicializa el unix2dos, recibiendo  como parametros los files que serviran de input u output para el programa. De ser estos nulos, se usara el comportamiento por default que es utilizar la entrada y salida estandar.
//
int Unix2dos_create(Unix2dos_t * unix2dos, FILE * input, FILE * output) {

	if (input) {
		unix2dos -> _fin = input;
	} else {
		unix2dos -> _fin =  stdin;
	}

	if (output) {
		unix2dos -> _fout = output;
	} else {
		unix2dos -> _fout =  stdout;
	}
	printf("Se crep correctamente");
	
	return 0;
}

int Unix2dos_start(Unix2dos_t * unix2dos) {
printf("se metio");
	int character;
        do {
                character = fgetc (unix2dos -> _fin);
                if(character == '\n') {
                        printf("un barra n");
                        fputc('\r',unix2dos->_fout);
                        fputc(character,unix2dos->_fout);
                }else {
                        printf("The integer is %c \n",(char)character);
                        fputc(character,unix2dos->_fout);
                }
        }while (character != EOF);

 
  	return 0;
 }	





