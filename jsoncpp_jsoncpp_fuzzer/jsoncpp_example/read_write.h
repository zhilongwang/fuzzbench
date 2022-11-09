#pragma once


#include <json/json.h>

class ReadWrite {
 public:
    void ReadJson();

    void ReadJson2();

    void WriteJson();

    void WriteJson2();

    void JsonTraversal();

 private:
    void OutputJson(const Json::Value &root, const std::string &pre);
};
