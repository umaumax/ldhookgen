    .data
hello:
    .string "Hello world!\n"

    .text
    .global _Z5func8iiiiiiii

_Z5func8iiiiiiii:
    pushq %rbp # pushq automatically %rsp += 0x08
    movq  %rsp,%rbp
    pushq %rdi # arg1
    pushq %rsi # arg2
    pushq %rdx # arg3
    pushq %rcx # arg4
    pushq %r8  # arg5
    pushq %r9  # arg6

    # you can set pre call functions here
    movq  $1, %rax
    movq  $1, %rdi
    movq  hello@GOTPCREL(%rip), %rsi
    movq  $13, %rdx
    syscall

    call *_dlsym_next@GOTPCREL(%rip)
    # %rax is hooked func addr

    popq %r9  # arg6
    popq %r8  # arg5
    popq %rcx # arg4
    popq %rdx # arg3
    popq %rsi # arg2
    popq %rdi # arg1
    movq %rbp, %rsp
    popq %rbp # popq automatically %rsp -= 0x08

    # case: no post hook call
    # call target hooked function
    jmpq *%rax
