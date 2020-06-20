# libtrace

## how to build
```
g++ -std=c++11 main.cpp -o libtrace_test -L. -lfuncs
g++ -shared -fPIC -std=c++11 funcs.cpp -o libfuncs.so
g++ -shared -fPIC -std=c++11 auto_gen.cpp -o libauto_gen.so -ldl

# WIP
nasm -felf64 auto_gen.s -o auto_gen.o
g++ -shared -fPIC -std=c++11 auto_gen.o -o libauto_gen.so -ldl

as -o auto_gen.o auto_gen_at.s
g++ -shared -fPIC -std=c++11 auto_gen.o auto_gen_helper.cpp -o libauto_gen.so -ldl
```

-rdynamicを付加しても，exeの中の関数は入れ替えできない?あくまでもこのexeを共有ライブラリ扱いできるだけでは?
外からexeの中の関数を呼び出した場合はどうなる?
## how to run
```
LD_LIBRARY_PATH=. ./libtrace_test
LD_LIBRARY_PATH=. LD_PRELOAD=./libauto_gen.so ./libtrace_test
```
