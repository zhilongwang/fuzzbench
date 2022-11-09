#include "value_check.h"
#include "read_write.h"
#include "simple_checker.h"
#include <iostream>


int main() {
  ReadWrite read_write;
  std::cout << "------ Sample: Convert String to Json ------\n";
  read_write.ReadJson();
  std::cout << "\n";

  std::cout << "------ Sample: Convert String to Json 2 ----\n";
  read_write.ReadJson2();
  std::cout << "\n";

  std::cout << "------ Sample: Convert Json to String ------\n";
  read_write.WriteJson();
  std::cout << "\n";

  std::cout << "------ Sample: Convert Json to String 2 ----\n";
  read_write.WriteJson2();
  std::cout << "\n";

  std::cout << "------ Sample: Json Traversal         ------\n";
  read_write.JsonTraversal();
  std::cout << "\n";

  ValueCheck value_check;
  std::cout << "------ Sample: Check UInt Value       ------\n";
  value_check.CheckUInt();
  std::cout << "\n";

  std::cout << "------ Sample: Check Real Value       ------\n";
  value_check.CheckReal();
  std::cout << "\n";

  std::cout << "------ Sample: Check Bool Value       ------\n";
  value_check.CheckBool();
  std::cout << "\n";

  std::cout << "------ Sample: Check Bool 2 Value     ------\n";
  value_check.CheckBool2();
  std::cout << "\n";

  std::cout << "------ Sample: Check Real Value 2     ------\n";
  value_check.CheckReal2();
  std::cout << "\n";

  std::cout << "------ Sample: Check None             ------\n";
  value_check.CheckNone();
  std::cout << "\n";

  SimpleChecker simple_checker;
  std::cout << "------ Sample: Simple Checker         ------\n";
  simple_checker.CheckValue();
  std::cout << "\n";
  return 0;
}
