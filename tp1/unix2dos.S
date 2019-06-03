#include <mips/regdef.h>
#include <sys/syscall.h>
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
     .set noreorder
     .cpload t9
     .set reorder

     subu    sp,  sp,  32
     .cprestore 12
     sw      ra,  20(sp)
     sw      $fp, 16(sp)
     addiu   $fp, sp,  28	
	sw	a0,32(sp)
	sw	a1,36(sp) 
	


loop:
     
     li      a0,   0
     la      a1,   letra
     li      a2,   1
     li      v0,   SYS_read
     syscall

  bne  a3, zero,read_error #jump if erno 
     beq     v0 ,  zero, termina  

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
     
     j loop


agregar_r:
     subu   sp, sp, 32
     sw     ra, 20(sp)
     sw     $fp, 16(sp)
     addiu  $fp, sp, 28

     li  a0, 1
     la  a1, salto_r
     li  a2, 1
     li  v0, SYS_write    # print_str syscall
     syscall
     lw  ra, 20(sp)
     lw  $fp, 16(sp)
     addiu  sp, sp, 32
     jr ra

termina:
     lw  ra, 20(sp)
     lw  $fp, 16(sp)
     addiu  sp, sp, 32

     li v0, SYS_exit
     syscall
     jr ra

 read_error:
     la  a0, 0
     la  a1, rderr
     li  a2, 8
     li  v0, SYS_write    # print_str syscall
     lw  ra, 20(sp)
     lw  $fp, 16(sp)
     addiu  sp, sp, 32
     addi v0,zero,-1
     li v0, SYS_exit
     syscall

.end
