# test

## フックした関数の実行後に何らかの処理をする方法
現状は，`jmpq`でフック先の関数を呼び出しているが，フックした関数の実行後に何らかの処理を行う場合は，`callq`のようにリターンアドレス付きで呼び出す必要がある  
このとき，現在のフレームのリターンアドレスを待避して，そこに戻るべきアドレスを書き込んでから`jmpq`を行う必要がある  
さらに，スタックではなく，ヒープを利用し，マルチスレッドの場合を考慮し，thread localの場所にスタック構造で記憶必要がある(関数が再帰呼び出しされる可能性があるため)  
thread localな変数を利用するため，C言語の関数を呼び出す必要がある  

## how to build
```
g++ -shared -fPIC -std=c++11 funcs.cpp -o libfuncs.so
g++ -shared -fPIC -std=c++11 auto_gen.cpp -o libauto_gen.so -ldl
g++ -std=c++11 main.cpp -o libtrace_test -L. -lfuncs

# WIP
nasm -felf64 auto_gen.s -o auto_gen.o
g++ -shared -fPIC -std=c++11 auto_gen.o -o libauto_gen.so -ldl

as -o auto_gen.o auto_gen_at.s
g++ -shared -fPIC -std=c++11 auto_gen.o auto_gen_helper.cpp -o libauto_gen.so -ldl
```

## how to run
```
LD_LIBRARY_PATH=. ./libtrace_test
LD_LIBRARY_PATH=. LD_PRELOAD=./libauto_gen.so ./libtrace_test
```
