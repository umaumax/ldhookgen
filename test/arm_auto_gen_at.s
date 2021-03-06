    .data
hello:
    .string "Hello world!\n"
    .equ    hello_len, . - hello

    .text
    .global _Z5func8iiiiiiii

_Z5func8iiiiiiii:
    push    {fp, lr}
    add     fp, sp, #4
    sub     sp, sp, #16
    str     r0, [fp, #-8]
    str     r1, [fp, #-12]
    str     r2, [fp, #-16]
    str     r3, [fp, #-20]

    // you can set pre call functions here
    /* syscall write(int fd, const void *buf, size_t count) */
    mov     r0, $1     /* fd := STDOUT_FILENO */
    ldr     r1, =hello       /* buf := message */
    ldr     r2, =hello_len   /* count := length */
    mov     r7, $4     /* write is syscall #4 */
    swi     $0         /* invoke syscall */

    bl _dlsym_next
    // r0 is hooked func addr
    mov r12, r0

    ldr r0, [fp, #-8]
    ldr r1, [fp, #-12]
    ldr r2, [fp, #-16]
    ldr r3, [fp, #-20]
    sub sp, fp, #4
    pop {fp, lr}
    // case: no post hook call
    // call target hooked function
    bx r12
