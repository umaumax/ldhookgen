#!/usr/bin/env bash

set -e

current_abs_directory_path=$(cd $(dirname $0) && pwd)
cd ${current_abs_directory_path%/}

AS=${AS:-as}
NM=${NM:-nm}
CXX=${CXX:-g++}
OBJDUMP=${OBJDUMP:-objdump}
READELF=${READELF:-${TARGET_PREFIX}readelf}
ARCH=${ARCH:-x86_64}

ELF_FILE=${ELF_FILE:-libtrace_test}
DSO_FILE=${DSO_FILE:-libfuncs.so}

# init
rm -f auto_gen_at_t_body.inc
rm -f auto_gen_dlsym_next_body.cpp

# NOTE: infomation of '.dynsym' is not removed by strip command

rm -f .func_list
touch .func_list
if [[ -f "$DSO_FILE" ]]; then
  if type "$READELF" >/dev/null 2>&1; then
    $READELF --dyn-syms "$DSO_FILE" | awk '$4=="FUNC" && $7!="UND" {print $8}' | sed 's/@.*$//' >>.func_list
  else
    $OBJDUMP --dynamic-syms "$DSO_FILE" | grep -F 'DF .text' | awk '{ print $NF }' >>.func_list
  fi
fi

if [[ -f "$ELF_FILE" ]]; then
  if type "$READELF" >/dev/null 2>&1; then
    $READELF --dyn-syms "$ELF_FILE" | awk '$4=="FUNC" && $7=="UND" {print $8}' | sed 's/@.*$//' >>.func_list
  else
    $OBJDUMP --dynamic-syms "$ELF_FILE" | grep -F 'DF *UND*' | awk '{ print $NF }' >>.func_list
  fi
fi
cat .func_list | sort | uniq >.func_list.tmp
mv .func_list.tmp .func_list

# TODO: Update below list
# blacklist
cat >.black_list <<EOF
_exit

_init
_fini

__cxa_atexit
__cxa_finalize
__libc_start_main
EOF
cat .func_list .black_list .black_list | sort | grep -v '^__' | uniq -u >.func_list.tmp
mv .func_list.tmp .func_list

function auto_gen() {
  local target="$1"
  cat ./${ARCH}_auto_gen_at_t.s.tmpl \
    | HOOK_FUNC_NAME="$target" DLSYM_NEXT_HOOK_FUNC_NAME="_dlsym_next${HOOK_FUNC_NAME}" envsubst '$HOOK_FUNC_NAME $DLSYM_NEXT_HOOK_FUNC_NAME' \
      >>auto_gen_at_t_body.inc

  cat auto_gen_dlsym_next.cpp.tmpl \
    | HOOK_FUNC_NAME="$target" DLSYM_NEXT_HOOK_FUNC_NAME="_dlsym_next${HOOK_FUNC_NAME}" envsubst '$HOOK_FUNC_NAME $DLSYM_NEXT_HOOK_FUNC_NAME' \
      >>auto_gen_dlsym_next_body.cpp
}

echo 'hook function list'
while IFS= read -r line || [[ -n "$line" ]]; do
  echo $line
  auto_gen "$line"
done < <(cat .func_list)

# build
$AS -o auto_gen.o auto_gen_at_t_main.s
$CXX -shared -fPIC -std=c++11 auto_gen.o auto_gen_dlsym_next_main.cpp -o libauto_gen.so -ldl
rm auto_gen.o

echo 'output file is libauto_gen.so'
