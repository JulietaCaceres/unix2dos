#include <mips/regdef.h>
#include <sys/syscall.h>

#       SRA
# 28    |_______PADDING________|
# 24    |_________RA___________|
# 20    |_________FP___________|
# 16    |_________GP___________|
#       Arguments for calle write y read
# 12    |_______PADDING _______|
# 8     |_________fd___________|
# 4     |_________msg__________|
# 0     |_________size_________|

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

     la      t0,  salto_n

loop:

     li      a0,   0
     la      a1,   letra
     li      a2,   1
     li      v0,   SYS_read
     syscall

     beq     v0 ,  zero, termina
     bltz    v0,   read_error

     lb      t0,   letra
     lb      t1,   salto_n
     bne     t0,   t1,    putc
     jal     agregar_r

putc:
     li      a0,    1
     la      a1,    letra
     li      a2,    1
     li      v0,    SYS_write    # print_str syscall
     syscall

     j loop

termina:

     lw      ra,   24(sp)
     lw      $fp,  20(sp)
     lw      gp,   16(sp)
     addu    sp,   sp,   SIZE

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

     addi    v0,   zero, -1
     li      v0,   SYS_exit
     syscall

# Función calle.
agregar_r:

#       SRA
# 28    |_______PADDING________|
# 24    |_________RA___________|
# 20    |_________FP___________|
# 16    |_________GP___________|
#       Arguments for callee write
# 12    |_______PADDING _______|
# 8     |_________fd___________|
# 4     |_________msg__________|
# 0     |_________size_________|

     subu    sp,    sp,  SIZE
     sw      ra,    24(sp)
     sw      $fp,   20(sp)
     sw      gp,    16(sp)
     move $fp,sp

     li      a0,    1
     la      a1,    salto_r
     li      a2,    1
     li      v0,    SYS_write
     syscall

     lw      ra,    24(sp)
     lw      $fp,   20(sp)
     lw      gp,    16(sp)
     addiu   sp,    sp,  SIZE
     jr ra

