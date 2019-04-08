#include <string.h>
#include <arpa/inet.h>
#include "unix2dos.h"
#include <stdio.h>


//Esta función inicializa el unix2dos, recibiendo  como parametros los files que serviran de input u output para el programa.
// De ser estos nulos, se usara el comportamiento por default que es utilizar la entrada y salida estandar.

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

	return 0;
}

// Método encargado de reemplazar \n por \r\n
//
int Unix2dos_start(Unix2dos_t * unix2dos) {
	int character;
	character = fgetc (unix2dos -> _fin);
	while (character != EOF){
                if(character == '\n') {
                        fputc('\r',unix2dos->_fout);
                        fputc(character,unix2dos->_fout);
                }else {
                        fputc(character,unix2dos->_fout);
                }
		character = fgetc (unix2dos -> _fin);
        }

 
  	return 0;
 }	





