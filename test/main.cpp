#include <iostream>
#include <string>

#include "funcs.hpp"

bool assert_check(int expected, int actual) {
  if (expected != actual) {
    std::cout << "NG(expected: " << expected << ", actual: " << actual << ")"
              << std::endl;
    return false;
  }
  std::cout << "OK" << std::endl;
  return true;
}

int main(int argc, char* argv[]) {
  bool ret = true;
  ret &= assert_check(0, func0());
  ret &= assert_check(1, func1(1));
  ret &= assert_check(3, func2(1, 2));
  ret &= assert_check(6, func3(1, 2, 3));
  ret &= assert_check(10, func4(1, 2, 3, 4));
  ret &= assert_check(15, func5(1, 2, 3, 4, 5));
  ret &= assert_check(21, func6(1, 2, 3, 4, 5, 6));
  ret &= assert_check(28, func7(1, 2, 3, 4, 5, 6, 7));
  ret &= assert_check(36, func8(1, 2, 3, 4, 5, 6, 7, 8));
  if (!ret) {
    return 1;
  }
  return 0;
}
