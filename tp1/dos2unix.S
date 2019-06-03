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
	.align 2
   	.globl main
		.ent main
main:



	.frame	$fp,40,ra		# vars= 16, regs= 2/0, args= 0, extra= 8
	.set	noreorder
	.cpload	t9
	.set	reorder

	#Stack frame creation
	subu	sp,sp,40

	.cprestore  20 			# equivale a  sw gp,20(sp) 
 	sw     ra, 28(sp)
 	sw     $fp, 24(sp)   	
	sw     s0, 32(sp)
 	sw     s1, 36(sp)
 	addiu  $fp, sp,0

	sw	a0,40(sp)
	sw	a1,44(sp) 
	sw	s2,16(sp)



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
  bne  a3, zero,error #jump if erno 

	beq s2,zero,flago   #jump if flag == 0
	
	lb t0,letra
	beq s1, t0,writeAndContinue  #jump if letra == \r

	beq s0, t0,dodgePutR 	#jump if letra == \n

  li  a0, 1
  la  a1, wsalto
  li  a2, 1
  li  v0, SYS_write   
  syscall   		      #fputc('\r');
  bne  a3, zero,error #jump if erno 

dodgePutR:
	add s2,zero,zero		#flag = 0;


writeAndContinue:
  li  a0, 1
  la  a1, letra
  li  a2, 1
  li  v0, SYS_write   
  syscall   					#fputc();
  bne  a3, zero,error #jump if erno 
 
  li  a0, 0
  la  a1, letra
  li  a2, 1
  li  v0, SYS_read
  syscall  					#getc()
  bne  a3, zero,error #jump if erno 
 
	j loop

flago:

	lb t0,letra
	beq s1, t0,setFlagAndContinue			#jump if letra == \r
	
  li  a0, 1
  la  a1, letra
  li  a2, 1
  li  v0, SYS_write   
  syscall   	            #fputc();
  bne  a3, zero,error #jump if erno 

  li  a0, 0
  la  a1, letra
  li  a2, 1
  li  v0, SYS_read
  syscall 								#getc()
  bne  a3, zero,error #jump if erno 

  j loop

setFlagAndContinue:
	addi s2,zero,1  			#flag = 1;

  li  a0, 0
  la  a1, letra
  li  a2, 1
  li  v0, SYS_read
  syscall 							#getc()
  bne  a3, zero,error #jump if erno 

  j loop

termina:
	beq s2,zero,cierra

  li  a0, 1
  la  a1, wsalto
  li  a2, 1
  li  v0, SYS_write   
  syscall   		      #fputc('\r');
  bne  a3, zero,error #jump if erno 

cierra:
  lw     ra, 28(sp)
  lw     $fp, 24(sp)   	
	lw     s0, 32(sp)
  lw     s1, 36(sp)
  addiu  $fp, sp,40
	lw s2,16(sp)
  jr ra


error:

  lw     ra, 28(sp)
  lw     $fp, 24(sp)   	
	lw     s0, 32(sp)
  lw     s1, 36(sp)
  addiu  $fp, sp,40
	lw s2,16(sp)

	addi v0,zero,-1
  jr ra
.end
