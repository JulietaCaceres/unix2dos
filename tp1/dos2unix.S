#include <mips/regdef.h>
#include <sys/syscall.h>


//STACK FRAME
//____________  40
//|  padding  | 36
//|-----------|
//|    ra     | 32
//|-----------|
//|    fp     | 28
//|-----------|
//|    gp     | 24
//|-----------|
//|  padding  | 20
//|-----------|
//|   flag    | 16
//|-----------|
//|    a3     | 12
//|-----------|
//|    a2     |  8
//|-----------|
//|    a1     |  4
//|-----------|
//|    a0     |  0
//|-----------|

#define SIZE 40
.data
   letra:	.space 1
   salto_n:	.asciiz "\n"
   salto_r:	.asciiz "\r"
   rderr:    	.asciiz       "Error realizando Read\n"
   wrerr:    	.asciiz       "Error realizando Write\n"

.text

     	.align 2
   	.globl main
	.ent main
main:
	.frame	$fp,SIZE,ra		# vars= 16, regs= 2/0, args= 0, extra= 8
	.set	noreorder
	.cpload	t9
	.set	reorder

	#Stack frame creation
	subu	sp,sp,SIZE

	.cprestore  20 			# equivale a  sw gp,20(sp) 

   	sw     ra, 28(sp)
   	sw     $fp, 24(sp)   	
	sw     s0, 32(sp)
   	sw     s1, 36(sp)
   	addiu  $fp, sp,0

	sw	a0,40(sp)
	sw	a1,44(sp) 

	sw	s2,20(sp)
	lb s0,salto_n
	lb s1,salto_r

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
	beq s1, t0,writeAndContinue  	#jump if letra == \r
	beq s0, t0,dodgePutR 		#jump if letra == \n



  	li  a0, 1
  	la  a1, salto_r
  	li  a2, 1
  	li  v0, SYS_write   
  	syscall   		      	#fputc('\r');
  bne  a3, zero,error #jump if erno 

dodgePutR:
	add s2,zero,zero		#flag = 0;


writeAndContinue:

  	li  a0, 1
  	la  a1, letra
  	li  a2, 1
  	li  v0, SYS_write   
  	syscall   			#fputc();
 		bne  a3, zero,error #jump if erno 
 
  	li  a0, 0
  	la  a1, letra
  	li  a2, 1
  	li  v0, SYS_read
  	syscall  			#getc()
  	bne  a3, zero,error #jump if erno 
 
	j loop

flago:

	lb t0,letra
	beq s1, t0,setFlagAndContinue	#jump if letra == \r
	
  li  a0, 1
  la  a1, letra
  li  a2, 1
  li  v0, SYS_write   
  syscall   	            #fputc();
  	bltz  v0, error 		#jump if erno 

  li  a0, 0
  la  a1, letra
  li  a2, 1
  li  v0, SYS_read
  syscall 								#getc()
  	bltz  v0, error 		#jump if erno 

  j loop


setFlagAndContinue:
	addi s2,zero,1  		#flag = 1;

  li  a0, 0
  la  a1, letra
  li  a2, 1
  li  v0, SYS_read
  syscall 							#getc()
  bltz  v0, error #jump if erno 

  	j loop

termina:
	beq s2,zero,cierra

  li  a0, 1
  la  a1, salto_r
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
	lw s2,20(sp)
  jr ra



error:
	li      a0,   0
     	la      a1,   rderr
     	li      a2,   8
     	li      v0,   SYS_write

     	lw     ra, 28(sp)
  	lw     $fp, 24(sp)   	
	lw     s0, 32(sp)

  	lw     s1, 36(sp)
  	addiu  $fp, sp,SIZE

     	addi    v0,   zero, -1
     	li      v0,   SYS_exit

.end main
