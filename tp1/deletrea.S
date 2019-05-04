#include <mips/regdef.h>
#include <sys/syscall.h>
.data
   message: .asciiz "Ingresar palabra para deletrear: "
   respuesta: .asciiz "\nUna letra es: "
   nombre:    .space 1
   salto: .asciiz "\n"
  end: .asciiz "Termina?\n"
  error_me: .asciiz "error?\n"
.text
   .globl main
main:
   subu   sp, sp, 32

   sw     ra, 20(sp)
   sw     $fp, 16(sp)
   addiu  $fp, sp, 28

  la  a0, 0
  la  a1, message
  li  a2, 33
  li  v0, SYS_write    # print_str syscall
  syscall

loop:
  la  a0, 1
  la  a1, nombre
  li  a2, 1
  li  v0, SYS_read
  syscall

  beq v0 , zero, termina
  bltz  v0, readerror
  la  a0, 0
  la  a1, respuesta
  li  a2, 15
  li  v0, SYS_write    # print_str syscall
  syscall


  la  a0, 0
  la  a1, nombre
  li  a2, 1
  li  v0, SYS_write    # print_str syscall
  syscall

  la  a0, 0
  la  a1, salto
  li  a2, 1
  li  v0, SYS_write    # print_str syscall
  syscall

  j loop
  
  termina:
  la  a0, 0
  la  a1, end
  li  a2, 9
  li  v0, SYS_write    # print_str syscall
  lw  ra, 20(sp)
  lw  $fp, 16(sp)
  addiu  sp, sp, 32

  li v0, SYS_exit
  syscall
  jr ra

readerror:
  la  a0, 0
  la  a1, error_me
  li  a2, 8
  li  v0, SYS_write    # print_str syscall
  lw  ra, 20(sp)
  lw  $fp, 16(sp)
  addiu  sp, sp, 32
  li v0, 10
  syscall

