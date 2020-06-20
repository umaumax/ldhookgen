#include <dlfcn.h>
#include <cstdio>
#include <cstdlib>

extern "C" {
void *_dlsym_next() {
  static void *(*fptr)() = 0;

  if (fptr == 0) {
    fptr = (void *(*)())dlsym(RTLD_NEXT, "_Z5func8iiiiiiii");
    if (fptr == nullptr) {
      (void)printf("dlopen: %s\n", dlerror());
      exit(1);
    }
  }

  return (void *)fptr;
}
}
