    .data
hello:
    .string "Hello world!\n"
    .equ hello_len, . - hello

    .include "auto_gen_at_t_body.inc"
