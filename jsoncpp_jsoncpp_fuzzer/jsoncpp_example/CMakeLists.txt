cmake_minimum_required(VERSION 3.2)
project(jsoncpp_example)
set(CMAKE_C_COMPILER /home/vagrant/touch_of_death/AFL/afl-clang-fast)
set(CMAKE_CXX_COMPILER /home/vagrant/touch_of_death/AFL/afl-clang-fast++)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0 -rtlib=compiler-rt -lgcc_s  -std=c++11")

include_directories(/usr/local/include)
link_directories(/usr/local/lib)

link_libraries(jsoncpp)

set(SOURCE_FILES main.cpp value_check.cpp read_write.cpp simple_checker.cpp simple_checker.h)
add_executable(jsoncpp_example ${SOURCE_FILES})
