# Install script for directory: /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/re2

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/re2" TYPE FILE FILES
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/re2/re2/filtered_re2.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/re2/re2/re2.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/re2/re2/set.h"
    "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/re2/re2/stringpiece.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/re2/libre2.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/re2/re2Config.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/re2/re2Config.cmake"
         "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/re2/CMakeFiles/Export/lib/cmake/re2/re2Config.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/re2/re2Config-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/re2/re2Config.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/re2" TYPE FILE FILES "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/re2/CMakeFiles/Export/lib/cmake/re2/re2Config.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/re2" TYPE FILE FILES "/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/re2/CMakeFiles/Export/lib/cmake/re2/re2Config-relwithdebinfo.cmake")
  endif()
endif()

