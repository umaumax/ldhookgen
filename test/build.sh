#!/usr/bin/env bash

current_abs_directory_path=$(cd $(dirname $0) && pwd)
cd ${current_abs_directory_path%/}

AS=${AS:-as}
NM=${NM:-nm}
CXX=${CXX:-g++}
OBJDUMP=${OBJDUMP:-objdump}
ARCH=${ARCH:-x86_64}

$CXX -shared -fPIC -std=c++11 funcs.cpp -o libfuncs.so
$CXX -shared -fPIC -std=c++11 auto_gen.cpp -o libauto_gen.so -ldl
$CXX -std=c++11 main.cpp -o libtrace_test -L. -lfuncs

$AS -o auto_gen.o ${ARCH}_auto_gen_at.s
$CXX -shared -fPIC -std=c++11 auto_gen.o auto_gen_helper.cpp -o libauto_gen.so -ldl
