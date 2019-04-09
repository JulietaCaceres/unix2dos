# Inicializa gxemul
gxemul:
	./gxemul/gxemul -e 3max -d gxemul/netbsd-pmax.img

# Este comando hay que ejecutarlo cada
# vez que reiniciamos nuestra computadora
loopback:
	sudo ifconfig lo:0 172.20.0.1

# Inicializa un shell remoto de NetBSD
ssh:
	sudo ssh -p 2222 root@127.0.0.1

# Envia los archivo .c del directorio actual
# a guest en la carpeta /root/tp0
c2guest:
	sudo scp -P2222 -r ./*.c root@127.0.0.1:/root/tp0

# Envia los archivo .h del directorio actual
# a guest en la carpeta /root/tp0	
h2guest:
	sudo scp -P2222 -r ./*.h root@127.0.0.1:/root/tp0

# Envia los archivo Makefile del directorio actual
# a guest en la carpeta /root/tp0	
make2guest:
	sudo scp -P2222 ./Makefile root@127.0.0.1:/root/tp0
# Envia los archivos de prueba
test2guest:
	sudo scp -P2222 -r ./pruebas root@127.0.0.1:/root/tp0
	sudo scp -P2222 -r ./exceptionTest.sh root@127.0.0.1:/root/tp0
	sudo scp -P2222 -r ./testFiles root@127.0.0.1:/root/tp0

# Se ejecuta del lado de guest
# genera el archivo assembly
asm:
	gcc -Wall -O0 -S -mrnames *.c 

# Compila y genera un binario
# desde el lado del guest
bin:
	gcc -Wall -o unix2dos main_unix2dos.c unix2dos.c
	gcc -Wall -o dos2unix main_dos2unix.c dos2unix.c
# Ejecuta los test.
test: bin
	chmod +x pruebas
	./pruebas
	sh testException.sh
.PHONY: gxemul loopback
