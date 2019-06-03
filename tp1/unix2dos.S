#include <mips/regdef.h>
#include <sys/syscall.h>


#define SIZE 28
.data
     letra:    .space        1
     salto_n:  .asciiz       "\n"
     salto_r:  .asciiz       "\r"
     rderr:    .asciiz       "Error realizando Read\n"
     wrerr:    .asciiz       "Error realizando Write\n"

.text
     .align 2
     .global main
     .ent main

main:
     .frame $fp,  SIZE, ra
     .set noreorder
     .cpload t9
     .set reorder

     subu    sp,  sp,  SIZE
     .cprestore 16
     sw      ra,  24(sp)
     sw      $fp, 20(sp)
     sw      gp,  16(sp)
     move $fp,sp
	sw	a0,32(sp)
	sw	a1,36(sp) 

loop:

     li      a0,   0
     la      a1,   letra
     li      a2,   1
     li      v0,   SYS_read
     syscall

	beq v0, 0, termina  #jump if EOF

  bne  a3, zero,read_error #jump if erno

     lb      t0,   letra
     lb      t1,   salto_n
     bne     t0,   t1,    putc
     b     agregar_r

putc:
     li      a0,    1
     la      a1,    letra
     li      a2,    1
     li      v0,    SYS_write    # print_str syscall
     syscall

     b  loop

termina:
     lw      ra,   24(sp)
     lw      $fp,  20(sp)
     lw      gp,   16(sp)
     addu    sp,   sp,   SIZE
	lw	a0,32(sp)
	lw	a1,36(sp) 
     li      v0,   SYS_exit
     syscall
     jr ra

 read_error:
     li      a0,   0
     la      a1,   rderr
     li      a2,   8
     li      v0,   SYS_write

     lw      ra,   24(sp)
     lw      $fp,  20(sp)
     lw      gp,   15(sp)
     addiu   sp,   sp,   SIZE
	lw	a0,32(sp)
	lw	a1,36(sp) 
     addi    v0,   zero, -1
     li      v0,   SYS_exit
     syscall

agregar_r:    
  li  a0, 1
  la  a1, salto_r
  li  a2, 1
  li  v0, SYS_write   
  syscall 

  bne  a3, zero,read_error #jump if erno
	li      a0,    1
     la      a1,    salto_n
     li      a2,    1
     li      v0,    SYS_write    # print_str syscall
     syscall

  bne  a3, zero,read_error #jump if erno
	b loop


.end main
