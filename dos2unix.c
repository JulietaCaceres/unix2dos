#include <stdlib.h>
#include <stdio.h>



int main(int argc, char *argv[]){	
	FILE * fdr = NULL;
	FILE * fdw = NULL;
	if(argc == 1){//leer y escribir en stdio y out
		fdr = stdin;
		fdw = stdout;
	}else if(argc == 3 ){
		if(!strcmp(argv[1],"-i")){
			fdr = fopen(argv[2],"r");
			fdw = stdout;
		}else if(!strcmp(argv[1],"-o")){			
			fdw = fopen(argv[2],"w");
			fdr = stdin;
		}else{
			printf("error en los parametros de entrada");
			return 0;
		}	
	}else if(argc == 5 ){
		if(!strcmp(argv[1],"-i") && !strcmp(argv[3],"-o")){
			fdw = fopen(argv[4],"w");
			fdr = fopen(argv[2],"r");
		}else if(!strcmp(argv[3],"-i") && !strcmp(argv[1],"-o")){
			fdw = fopen(argv[2],"w");
			fdr = fopen(argv[4],"r");
		}else{
			printf("error en los parametros de entrada");
			return 0;
		}
	}else{
		printf("error en los parametros de entrada");
		return 0;
	}
	char c;
	char flag = 0;//flag == 1 -> el c anteriro fue \r
	c = fgetc(fdr);
	while(!feof(fdr)){
		if(flag){
			if(c == '\r'){
				flag == 1;
			}else if(c == '\n'){
				flag = 0;
			}else{
				fputc('\r',fdw);
				flag = 0;	
			}	
			fputc(c,fdw);	
		}else
			if(c == '\r'){
				flag = 1;			
			}else				
				fputc(c,fdw);	

		c = fgetc(fdr);	
	}		
	fclose(fdw);
	fclose(fdr);
	return 0;
}
