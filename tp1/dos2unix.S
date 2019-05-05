#include <mips/regdef.h>
#include <sys/syscall.h>
.data
   respuesta: .asciiz "\nUna letra es: "
   letra:    .space 1
   salto: .asciiz "\n"
   wsalto: .asciiz "\r"
  end: .asciiz "Termina?\n"
  error_me: .asciiz "error?\n"
.text
   .globl main
main:
   subu   sp, sp, 32

   sw     ra, 20(sp)
   sw     $fp, 16(sp)
   addiu  $fp, sp, 28


	lb s0,salto
	lb s1,wsalto
	add s2,zero,zero

  li  a0, 0
  la  a1, letra
  li  a2, 1
  li  v0, SYS_read
  syscall

loop:

	beq v0, 0, termina  #jump if EOF
  bltz  v0, readerror #jump if erno 

	beq s2,zero,flago   #jump if flag == 0
	
	lb t0,letra
	beq s1, t0,writeAndContinue  #jump if letra == \r

	beq s0, t0,dodgePutR 	#jump if letra == \n

  li  a0, 1
  la  a1, wsalto
  li  a2, 1
  li  v0, SYS_write   
  syscall   		      #fputc('\r');

dodgePutR:
	add s2,zero,zero		#flag = 0;


writeAndContinue:
  li  a0, 1
  la  a1, letra
  li  a2, 1
  li  v0, SYS_write   
  syscall   					#fputc();
				
  li  a0, 0
  la  a1, letra
  li  a2, 1
  li  v0, SYS_read
  syscall  					#getc()

	j loop

flago:

	lb t0,letra
	beq s1, t0,setFlagAndContinue			#jump if letra == \r
	
  li  a0, 1
  la  a1, letra
  li  a2, 1
  li  v0, SYS_write   
  syscall   	            #fputc();

  li  a0, 0
  la  a1, letra
  li  a2, 1
  li  v0, SYS_read
  syscall 								#getc()

  j loop

setFlagAndContinue:
	addi s2,zero,1  			#flag = 1;

  li  a0, 0
  la  a1, letra
  li  a2, 1
  li  v0, SYS_read
  syscall 							#getc()

  j loop

termina:
  li  a0, 1
  la  a1, end
  li  a2, 9
  li  v0, SYS_write    # print_str syscall
  lw  ra, 20(sp)
  lw  $fp, 16(sp)
  addiu  sp, sp, 32
  jr ra


readerror:
  li  a0, 1
  la  a1, error_me
  li  a2, 8
  li  v0, SYS_write    # print_str syscall
  lw  ra, 20(sp)
  lw  $fp, 16(sp)
  addiu  sp, sp, 32
  li v0, 10
  syscall

