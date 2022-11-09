#include "simple_checker.h"
#include <iostream>
#include <algorithm>

void SimpleChecker::CheckValue() {
  JsonCheckList check_list = {
    {"bool1", JSON_BOOL_VALUE},
    {"bool2", JSON_INT_VALUE},
    {"bool3", JSON_UINT_VALUE},

    {"int1", JSON_INT_VALUE},
    {"int2", JSON_INT64_VALUE},
    {"int3", JSON_UINT_VALUE},
    {"int4", JSON_UINT64_VALUE},

    {"double1", JSON_REAL_VALUE},
    {"double2", JSON_INT_VALUE},
    {"double3", JSON_UINT_VALUE},
  };

  Json::Value root;
  root["bool1"] = true;
  root["bool2"] = false;
  root["bool3"] = true;

  root["int1"] = -1;
  root["int2"] = 1;
  root["int3"] = 2;
  root["int4"] = 3;

  root["double1"] = 1;
  root["double2"] = 1.0;
  root["double3"] = 2;

  auto result = CheckJsonValue(root, check_list);
  while (!result.first) {
    std::cout << result.second << " check failed" << std::endl;
    check_list.erase(result.second);
    result = CheckJsonValue(root, check_list);
  }

  std::cout << "check success" << std::endl;
}


JsonCheckResult SimpleChecker::CheckJsonValue(const Json::Value &val, const JsonCheckList &check_list) {
  JsonValueKey error_key;
  return std::make_pair(
    std::find_if(check_list.begin(), check_list.end(), [&](const JsonCheckList::value_type &check_item) {
        auto rule_iter = kCheckRule.find(check_item.second);
        if (rule_iter == kCheckRule.end()) {
          return true;
        }

        if (!(val[check_item.first].*(rule_iter->second))()) {
          error_key = check_item.first;
          return true;
        }
        return false;
    }) == check_list.end(),
    error_key);
}
