bits 64
section .text
global _Z5func1i

_Z5func1i:
  xor     eax, eax
  mov     edx, eax
  inc     eax         ; sys_write (01)
  mov     edi, eax    ; stdout    (01)
  mov     dl, len     ; length    (13)
  mov     rsi, msg    ; address
  syscall
  mov     rax, 0xff
  ret

section .data
        msg     db      'hello, world', 0x0A
        len     equ     $ - msg
