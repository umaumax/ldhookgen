#include <dlfcn.h>
#include <cstdio>
#include <cstdlib>

extern "C" {
void *_Z5func0v(void *arg1, void *arg2, void *arg3, void *arg4) {
  printf("%p,%p,%p,%p\n", arg1, arg2, arg3, arg4);
  static void *(*fptr)(void *, void *, void *, void *) = 0;

  if (fptr == 0) {
    fptr = (void *(*)(void *, void *, void *, void *))dlsym(RTLD_NEXT,
                                                            "_Z5func0v");
    if (fptr == nullptr) {
      (void)printf("dlopen: %s\n", dlerror());
      exit(1);
    }
  }

  return ((*fptr)(arg1, arg2, arg3, arg4));
}

void *_Z5func1i(void *arg1, void *arg2, void *arg3, void *arg4) {
  printf("%p,%p,%p,%p\n", arg1, arg2, arg3, arg4);
  static void *(*fptr)(void *, void *, void *, void *) = 0;

  if (fptr == 0) {
    fptr = (void *(*)(void *, void *, void *, void *))dlsym(RTLD_NEXT,
                                                            "_Z5func1i");
    if (fptr == nullptr) {
      (void)printf("dlopen: %s\n", dlerror());
      exit(1);
    }
  }

  return ((*fptr)(arg1, arg2, arg3, arg4));
}

void *_Z5func2ii(void *arg1, void *arg2, void *arg3, void *arg4) {
  printf("%p,%p,%p,%p\n", arg1, arg2, arg3, arg4);
  static void *(*fptr)(void *, void *, void *, void *) = 0;

  if (fptr == 0) {
    fptr = (void *(*)(void *, void *, void *, void *))dlsym(RTLD_NEXT,
                                                            "_Z5func2ii");
    if (fptr == nullptr) {
      (void)printf("dlopen: %s\n", dlerror());
      exit(1);
    }
  }

  return ((*fptr)(arg1, arg2, arg3, arg4));
}

void *_Z5func3iii(void *arg1, void *arg2, void *arg3, void *arg4) {
  printf("%p,%p,%p,%p\n", arg1, arg2, arg3, arg4);
  static void *(*fptr)(void *, void *, void *, void *) = 0;

  if (fptr == 0) {
    fptr = (void *(*)(void *, void *, void *, void *))dlsym(RTLD_NEXT,
                                                            "_Z5func3iii");
    if (fptr == nullptr) {
      (void)printf("dlopen: %s\n", dlerror());
      exit(1);
    }
  }

  return ((*fptr)(arg1, arg2, arg3, arg4));
}

void *_Z5func4iiii(void *arg1, void *arg2, void *arg3, void *arg4) {
  printf("%p,%p,%p,%p\n", arg1, arg2, arg3, arg4);
  static void *(*fptr)(void *, void *, void *, void *) = 0;

  if (fptr == 0) {
    fptr = (void *(*)(void *, void *, void *, void *))dlsym(RTLD_NEXT,
                                                            "_Z5func4iiii");
    if (fptr == nullptr) {
      (void)printf("dlopen: %s\n", dlerror());
      exit(1);
    }
  }

  return ((*fptr)(arg1, arg2, arg3, arg4));
}

void *_Z5func5iiiii(void *arg1, void *arg2, void *arg3, void *arg4,
                    void *arg5) {
  printf("%p,%p,%p,%p,%p\n", arg1, arg2, arg3, arg4, arg5);
  static void *(*fptr)(void *, void *, void *, void *, void *) = 0;

  if (fptr == 0) {
    fptr = (void *(*)(void *, void *, void *, void *, void *))dlsym(
        RTLD_NEXT, "_Z5func5iiiii");
    if (fptr == nullptr) {
      (void)printf("dlopen: %s\n", dlerror());
      exit(1);
    }
  }

  return ((*fptr)(arg1, arg2, arg3, arg4, arg5));
}

void *_Z5func6iiiiii(void *arg1, void *arg2, void *arg3, void *arg4, void *arg5,
                     void *arg6) {
  printf("%p,%p,%p,%p,%p,%p\n", arg1, arg2, arg3, arg4, arg5, arg6);
  static void *(*fptr)(void *, void *, void *, void *, void *, void *) = 0;

  if (fptr == 0) {
    fptr = (void *(*)(void *, void *, void *, void *, void *, void *))dlsym(
        RTLD_NEXT, "_Z5func6iiiiii");
    if (fptr == nullptr) {
      (void)printf("dlopen: %s\n", dlerror());
      exit(1);
    }
  }

  return ((*fptr)(arg1, arg2, arg3, arg4, arg5, arg6));
}

// 6個の引数ではNGで，7個でOK
// そうか結局，ある引数のstackpointerを指している値は取れない?
void *_Z5func7iiiiiii(void *arg1, void *arg2, void *arg3, void *arg4,
                      void *arg5, void *arg6, void *arg7) {
  printf("%p,%p,%p,%p,%p,%p,%p\n", arg1, arg2, arg3, arg4, arg5, arg6, arg7);
  static void *(*fptr)(void *, void *, void *, void *, void *, void *, void *) =
      0;

  if (fptr == 0) {
    fptr = (void *(*)(void *, void *, void *, void *, void *, void *,
                      void *))dlsym(RTLD_NEXT, "_Z5func7iiiiiii");
    if (fptr == nullptr) {
      (void)printf("dlopen: %s\n", dlerror());
      exit(1);
    }
  }

  return ((*fptr)(arg1, arg2, arg3, arg4, arg5, arg6, arg7));
}

void *_Z5func8iiiiiiii(void *arg1, void *arg2, void *arg3, void *arg4,
                       void *arg5, void *arg6, void *arg7, void *arg8) {
  printf("%p,%p,%p,%p,%p,%p,%p,%p\n", arg1, arg2, arg3, arg4, arg5, arg6, arg7,
         arg8);
  static void *(*fptr)(void *, void *, void *, void *, void *, void *, void *,
                       void *) = 0;

  if (fptr == 0) {
    fptr = (void *(*)(void *, void *, void *, void *, void *, void *, void *,
                      void *))dlsym(RTLD_NEXT, "_Z5func8iiiiiiii");
    if (fptr == nullptr) {
      (void)printf("dlopen: %s\n", dlerror());
      exit(1);
    }
  }

  return ((*fptr)(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
}
}
