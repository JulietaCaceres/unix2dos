#include <string.h>
#include <arpa/inet.h>
#include "dos2unix.h"
#include <stdio.h>


//Esta función inicializa el dos2unix, recibiendo  como parametros los files que serviran de input u output para el programa.
//De ser estos nulos, se usara el comportamiento por default que es utilizar la entrada y salida estandar.
//
int Dos2unix_create(Dos2unix_t * dos2unix, FILE * input, FILE * output) {

	if (input) {
		dos2unix -> _fin = input;
	} else {
		dos2unix -> _fin =  stdin;
	}

	if (output) {
		dos2unix -> _fout = output;
	} else {
		dos2unix -> _fout =  stdout;
	}
	
	return 0;
}

// Método encargado de reemplazar /r/n por /n
int Dos2unix_start(Dos2unix_t * dos2unix) {

	int character;
	int flag = 0;
	character = fgetc (dos2unix -> _fin);
	while (character != EOF){
		if (flag == 1){	
			if (character == '\r') {
				flag = 1;
			}else if(character == '\n') {
				flag = 0;
			}else{
				fputc('\r',dos2unix->_fout);
				flag = 0;
			}
            	fputc(character,dos2unix->_fout);
		}else {
			if (character == '\r') {
				flag = 1;
			}else{
				fputc(character,dos2unix->_fout);
			}
                }
		character = fgetc(dos2unix -> _fin);
        }

 
  	return 0;
 }	





