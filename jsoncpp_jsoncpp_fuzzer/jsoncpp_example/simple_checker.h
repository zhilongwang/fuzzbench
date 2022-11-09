#pragma once
#include <json/json.h>


enum JsonType {
    JSON_NULL_VALUE     = 0,
    JSON_INT_VALUE      = 1,
    JSON_INT64_VALUE    = 2,
    JSON_UINT_VALUE     = 3,
    JSON_UINT64_VALUE   = 4,
    JSON_REAL_VALUE     = 5,
    JSON_STRING_VALUE   = 6,
    JSON_BOOL_VALUE     = 7,
    JSON_ARRAY_VALUE    = 8,
    JSON_OBJECT_VALUE   = 9,
};


static const std::map<uint32_t, bool (Json::Value:: *)() const> kCheckRule = {
  {JSON_INT_VALUE,    &Json::Value::isInt},
  {JSON_INT64_VALUE,  &Json::Value::isInt64},
  {JSON_UINT_VALUE,   &Json::Value::isUInt},
  {JSON_UINT64_VALUE, &Json::Value::isUInt64},
  {JSON_REAL_VALUE,   &Json::Value::isDouble},
  {JSON_STRING_VALUE, &Json::Value::isString},
  {JSON_BOOL_VALUE,   &Json::Value::isBool},
  {JSON_ARRAY_VALUE,  &Json::Value::isArray},
  {JSON_OBJECT_VALUE, &Json::Value::isObject},
};


typedef std::string                       JsonValueKey;
typedef std::map<JsonValueKey, JsonType>  JsonCheckList;
typedef std::pair<bool, JsonValueKey>     JsonCheckResult;


class SimpleChecker {
 public:
  void CheckValue();
 private:
  JsonCheckResult CheckJsonValue(const Json::Value &val, const JsonCheckList &check_list);
};
