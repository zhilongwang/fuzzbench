# Install script for directory: /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RelWithDebInfo")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/capstone" TYPE FILE FILES
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/arm64.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/arm.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/capstone.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/evm.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/mips.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/ppc.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/x86.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/sparc.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/systemz.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/xcore.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/m68k.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/tms320c64x.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/m680x.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/mos65xx.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/capstone/include/capstone/platform.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/capstone/libcapstone.a")
endif()

