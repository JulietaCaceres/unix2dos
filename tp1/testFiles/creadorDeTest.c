#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <getopt.h>
#include <stdbool.h>
#include <unistd.h>

#define cantPruebas 5

char tctxt[cantPruebas][200] = {  
{"Hola\nMunda\n\nBy!\0"},
{"Hola denuevo, esta vez voy a intentar confundirte usando valores diferentes a \n como \x01,\x02,\x99,\x37,seguidos por un \n\0"},
{"\n\0"},
{"\0"},
{"La ultima prueba que se me ocurre son muchos \r\r\r\r\r\n\r y el n al final para molestar"}
};


char tcstxt[cantPruebas][200] = {  
{"Hola\r\nMunda\r\n\r\nBy!\0"},
{"Hola denuevo, esta vez voy a intentar confundirte usando valores diferentes a \r\n como \x01,\x02,\x99,\x37,seguidos por un \r\n\0"},
{"\r\n\0"},
{"\0"},
{"La ultima prueba que se me ocurre son muchos \r\r\r\r\r\r\n\r y el n al final para molestar"}

};

char tcname[cantPruebas][100] = {  
{"testFiles/testCase1\0"},
{"testFiles/testCase2\0"},
{"testFiles/testCase3\0"},
{"testFiles/testCase4\0"},
{"testFiles/testCase5\0"},
};


char tcsname[cantPruebas][100] = {  
{"testFiles/testCaseSol1\0"},
{"testFiles/testCaseSol2\0"},
{"testFiles/testCaseSol3\0"},
{"testFiles/testCaseSol4\0"},
{"testFiles/testCaseSol5\0"},

};


int main(){
	FILE * tc;
	FILE * tcs;
	int i = 0;	
	while(i < cantPruebas){
		tc = fopen(tcname[i],"w");
		tcs = fopen(tcsname[i],"w");
		fprintf(tc,"%s",tctxt[i]);
		fprintf(tcs,"%s",tcstxt[i]);
		i++;
		fclose(tc);
		fclose(tcs);	
	}

	return 1;
}
