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

# Envia los archivo .S del directorio actual
# a guest en la carpeta /root/tp1
s2guest:
	sudo scp -P2222 -r ./*.S root@127.0.0.1:/root/tp1

# Envia el archivo Makefile del directorio actual
# a guest en la carpeta /root/tp1	
make2guest:
	sudo scp -P2222 ./Makefile root@127.0.0.1:/root/tp1
# Envia los archivos de prueba
test2guest:
	sudo scp -P2222 -r ./pruebas root@127.0.0.1:/root/tp1
	sudo scp -P2222 -r ./exceptionTest.sh root@127.0.0.1:/root/tp1
	sudo scp -P2222 -r ./testFiles root@127.0.0.1:/root/tp1

# Compila y genera un binario
# desde el lado del guest
bin:
	gcc -Wall -o unix2dos  unix2dos.S
	gcc -Wall -o dos2unix  dos2unix.S

# Ejecuta los test.
test: 
	bash pruebas
	sh exceptionTest.sh
.PHONY: gxemul loopback
