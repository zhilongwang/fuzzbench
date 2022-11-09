#include "read_write.h"

#include <json/json.h>
#include <numeric>
#include <sstream>
#include <iostream>
#include <fstream>


void ReadWrite::ReadJson() {
  std::string json = "{\"name\":\"Tom\",\"age\":29,\"weight\":65.2,\"height\":175,\"children\":[\"Bob\",\"Alice\"]}";
  Json::Value root;

  std::stringstream ss{json};
  Json::CharReaderBuilder builder;
  std::string errs;
  bool ret = Json::parseFromStream(builder, ss, &root, &errs);
  if (!ret || !root.isObject()) {
    std::cout << "cannot convert string to json, err: " << errs << std::endl;
    return;
  }

  std::string name    = root["name"].asString();
  int32_t     age     = root["age"].asInt();
  double      weight  = root["weight"].asDouble();
  uint32_t    height  = root["height"].asUInt();

  std::vector<std::string> children_names;
  Json::Value children = root["children"];
  if (!children.isNull() && children.isArray()) {
    for (uint32_t i = 0; i < children.size(); ++i) {
      children_names.push_back(children[i].asString());
    }
  }

  std::cout << "ConvertStringToJson, Name: " << name << ", age: " << age << ", weight: " << weight
            << ", height: " << height << ", children: "
            << std::accumulate(std::next(children_names.begin()), children_names.end(),
                               std::string{*children_names.begin()},
                               [](std::string out, const std::string &in){return out + ", " + in;})
            << std::endl;
}


void ReadWrite::ReadJson2() {
  std::string json = "{\"name\":\"Tom\",\r\n\"age\":29,\r\n\"weight\":65.2,\r\n\"height\":175,\r\n\"children\":[\"Bob\",\r\n\"Alice\"]}";
  Json::Value root;
  std::stringstream ss{json};
  Json::CharReaderBuilder builder;
  std::string errs;
  bool ret = Json::parseFromStream(builder, ss, &root, &errs);
  if (!ret || !root.isObject()) {
    std::cout << "cannot convert string to json, err: " << errs << std::endl;
    return;
  }
  std::cout << "convert string to json" << std::endl;
}


void ReadWrite::WriteJson() {
  Json::Value root(Json::objectValue);
  root["name"] = "Tom";
  root["age"] = 29;
  root["weight"] = 65.2;
  root["height"] = 175;
  Json::Value children(Json::arrayValue);
  children.append("Bob");
  children.append("Alice");
  root["children"] = children;

  // FastWriter, StyledWriter, StyledStreamWriter, and Writer are deprecated.
  // Use StreamWriterBuilder, which creates a StreamWriter with a slightly different API
  Json::StreamWriterBuilder builder;
  builder.settings_["indentation"] = "";
  std::unique_ptr<Json::StreamWriter> writer(builder.newStreamWriter());
  std::stringstream ss;
  writer->write(root, &ss);

  std::cout << "ConvertJsonToString, json: " << ss.str() << std::endl;
}


void ReadWrite::WriteJson2() {
  Json::Value root(Json::objectValue);
  root["name"] = "Tom";
  root["age"] = 29;
  root["weight"] = 65.2;
  root["height"] = 175;
  Json::Value children(Json::arrayValue);
  children.append("Bob");
  children.append("Alice");
  root["children"] = children;

  // FastWriter, StyledWriter, StyledStreamWriter, and Writer are deprecated.
  // Use StreamWriterBuilder, which creates a StreamWriter with a slightly different API
  Json::StreamWriterBuilder builder;
  builder.settings_["indentation"] = "\r";
  std::unique_ptr<Json::StreamWriter> writer(builder.newStreamWriter());
  std::stringstream ss;
  writer->write(root, &ss);

  std::ofstream ofs;
  ofs.open("/tmp/test.json");
  writer->write(root, &ofs);

  std::cout << "ConvertJsonToString, json: " << ss.str() << std::endl;
}


void ReadWrite::JsonTraversal() {
  Json::Value root(Json::objectValue);
  root["name"] = "Tom";
  root["age"] = 29;
  root["weight"] = 65.2;
  root["height"] = 175;
  Json::Value children(Json::arrayValue);

  Json::Value child_bob(Json::objectValue);
  child_bob["name"] = "Bob";
  child_bob["age"] = 3;
  children.append(child_bob);

  Json::Value child_alice(Json::objectValue);
  child_alice["name"] = "Alice";
  child_alice["age"] = 1;
  children.append(child_alice);

  root["children"] = children;

  Json::Value children_name(Json::arrayValue);
  children_name.append("Bob");
  children_name.append("Alice");
  root["children_name"] = children_name;

  OutputJson(root, "");
}


void ReadWrite::OutputJson(const Json::Value &root, const std::string &pre) {
  if (!root.isObject()) {
    std::cout << pre << root.asString() << ",\n";
    return;
  }

  Json::Value::Members members = root.getMemberNames();
  std::cout << pre << "{\n";
  for (auto iter = members.begin(); iter != members.end(); ++iter) {
    uint32_t value_type = root[*iter].type();
    std::cout << pre << "\t\"" << *iter << "(" << value_type << ")\": ";
    if (value_type == Json::objectValue) {
      OutputJson(root[*iter], "\t\t");
    } else if (value_type == Json::arrayValue) {
      std::cout << pre << "[\n";
      for (int i = 0; i < root[*iter].size(); ++i) {
        OutputJson(root[*iter][i], "\t\t");
      }
      std::cout << pre << "\t],\n";
    } else {
      std::cout << root[*iter].asString() << ",\n";
    }
  }
  std::cout << pre << "},\n";
}
