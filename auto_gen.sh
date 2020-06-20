#!/usr/bin/env bash

set -e

# init
rm -f auto_gen_at_t_body.inc
rm -f auto_gen_dlsym_next_body.cpp

# [Man page of MALLOC\_HOOK]( https://linuxjm.osdn.jp/html/LDP_man-pages/man3/malloc_hook.3.html )
# __malloc_hookはデバッグ用の変数であり，これを機械的に置換するとsegmentation faultとなる
# echo malloc >.func_list
# echo __malloc_hook >>.func_list
# objdump -R /lib/x86_64-linux-gnu/libc.so.6 | grep R_X86_64_GLOB_DAT | sed 's/@.*//' | awk '{print $3}' | grep -e malloc -e free >.func_list
nm libtrace_test | grep ' U ' | awk '{print $2}' | grep 'func' >.func_list

function auto_gen() {
  local target="$1"
  cat ./auto_gen_at_t.s.tmpl \
    | HOOK_FUNC_NAME="$target" DLSYM_NEXT_HOOK_FUNC_NAME="_dlsym_next${HOOK_FUNC_NAME}" envsubst \
      >>auto_gen_at_t_body.inc

  cat auto_gen_dlsym_next.cpp.tmpl \
    | HOOK_FUNC_NAME="$target" DLSYM_NEXT_HOOK_FUNC_NAME="_dlsym_next${HOOK_FUNC_NAME}" envsubst \
      >>auto_gen_dlsym_next_body.cpp
}

echo 'hook function list'
while IFS= read -r line || [[ -n "$line" ]]; do
  echo $line
  auto_gen "$line"
done < <(cat .func_list)

# build
as -o auto_gen.o auto_gen_at_t_main.s
g++ -shared -fPIC -std=c++11 auto_gen.o auto_gen_dlsym_next_main.cpp -o libauto_gen.so -ldl
rm auto_gen.o

echo 'output file is libauto_gen.so'
