# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.13

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example

# Include any dependencies generated for this target.
include CMakeFiles/jsoncpp_example.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/jsoncpp_example.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/jsoncpp_example.dir/flags.make

CMakeFiles/jsoncpp_example.dir/main.cpp.o: CMakeFiles/jsoncpp_example.dir/flags.make
CMakeFiles/jsoncpp_example.dir/main.cpp.o: main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/jsoncpp_example.dir/main.cpp.o"
	/home/vagrant/touch_of_death/AFL/afl-clang-fast++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/jsoncpp_example.dir/main.cpp.o -c /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/main.cpp

CMakeFiles/jsoncpp_example.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/jsoncpp_example.dir/main.cpp.i"
	/home/vagrant/touch_of_death/AFL/afl-clang-fast++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/main.cpp > CMakeFiles/jsoncpp_example.dir/main.cpp.i

CMakeFiles/jsoncpp_example.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/jsoncpp_example.dir/main.cpp.s"
	/home/vagrant/touch_of_death/AFL/afl-clang-fast++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/main.cpp -o CMakeFiles/jsoncpp_example.dir/main.cpp.s

CMakeFiles/jsoncpp_example.dir/value_check.cpp.o: CMakeFiles/jsoncpp_example.dir/flags.make
CMakeFiles/jsoncpp_example.dir/value_check.cpp.o: value_check.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/jsoncpp_example.dir/value_check.cpp.o"
	/home/vagrant/touch_of_death/AFL/afl-clang-fast++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/jsoncpp_example.dir/value_check.cpp.o -c /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/value_check.cpp

CMakeFiles/jsoncpp_example.dir/value_check.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/jsoncpp_example.dir/value_check.cpp.i"
	/home/vagrant/touch_of_death/AFL/afl-clang-fast++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/value_check.cpp > CMakeFiles/jsoncpp_example.dir/value_check.cpp.i

CMakeFiles/jsoncpp_example.dir/value_check.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/jsoncpp_example.dir/value_check.cpp.s"
	/home/vagrant/touch_of_death/AFL/afl-clang-fast++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/value_check.cpp -o CMakeFiles/jsoncpp_example.dir/value_check.cpp.s

CMakeFiles/jsoncpp_example.dir/read_write.cpp.o: CMakeFiles/jsoncpp_example.dir/flags.make
CMakeFiles/jsoncpp_example.dir/read_write.cpp.o: read_write.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/jsoncpp_example.dir/read_write.cpp.o"
	/home/vagrant/touch_of_death/AFL/afl-clang-fast++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/jsoncpp_example.dir/read_write.cpp.o -c /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/read_write.cpp

CMakeFiles/jsoncpp_example.dir/read_write.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/jsoncpp_example.dir/read_write.cpp.i"
	/home/vagrant/touch_of_death/AFL/afl-clang-fast++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/read_write.cpp > CMakeFiles/jsoncpp_example.dir/read_write.cpp.i

CMakeFiles/jsoncpp_example.dir/read_write.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/jsoncpp_example.dir/read_write.cpp.s"
	/home/vagrant/touch_of_death/AFL/afl-clang-fast++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/read_write.cpp -o CMakeFiles/jsoncpp_example.dir/read_write.cpp.s

CMakeFiles/jsoncpp_example.dir/simple_checker.cpp.o: CMakeFiles/jsoncpp_example.dir/flags.make
CMakeFiles/jsoncpp_example.dir/simple_checker.cpp.o: simple_checker.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/jsoncpp_example.dir/simple_checker.cpp.o"
	/home/vagrant/touch_of_death/AFL/afl-clang-fast++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/jsoncpp_example.dir/simple_checker.cpp.o -c /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/simple_checker.cpp

CMakeFiles/jsoncpp_example.dir/simple_checker.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/jsoncpp_example.dir/simple_checker.cpp.i"
	/home/vagrant/touch_of_death/AFL/afl-clang-fast++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/simple_checker.cpp > CMakeFiles/jsoncpp_example.dir/simple_checker.cpp.i

CMakeFiles/jsoncpp_example.dir/simple_checker.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/jsoncpp_example.dir/simple_checker.cpp.s"
	/home/vagrant/touch_of_death/AFL/afl-clang-fast++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/simple_checker.cpp -o CMakeFiles/jsoncpp_example.dir/simple_checker.cpp.s

# Object files for target jsoncpp_example
jsoncpp_example_OBJECTS = \
"CMakeFiles/jsoncpp_example.dir/main.cpp.o" \
"CMakeFiles/jsoncpp_example.dir/value_check.cpp.o" \
"CMakeFiles/jsoncpp_example.dir/read_write.cpp.o" \
"CMakeFiles/jsoncpp_example.dir/simple_checker.cpp.o"

# External object files for target jsoncpp_example
jsoncpp_example_EXTERNAL_OBJECTS =

jsoncpp_example: CMakeFiles/jsoncpp_example.dir/main.cpp.o
jsoncpp_example: CMakeFiles/jsoncpp_example.dir/value_check.cpp.o
jsoncpp_example: CMakeFiles/jsoncpp_example.dir/read_write.cpp.o
jsoncpp_example: CMakeFiles/jsoncpp_example.dir/simple_checker.cpp.o
jsoncpp_example: CMakeFiles/jsoncpp_example.dir/build.make
jsoncpp_example: CMakeFiles/jsoncpp_example.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable jsoncpp_example"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/jsoncpp_example.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/jsoncpp_example.dir/build: jsoncpp_example

.PHONY : CMakeFiles/jsoncpp_example.dir/build

CMakeFiles/jsoncpp_example.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/jsoncpp_example.dir/cmake_clean.cmake
.PHONY : CMakeFiles/jsoncpp_example.dir/clean

CMakeFiles/jsoncpp_example.dir/depend:
	cd /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/jsoncpp_jsoncpp_fuzzer/jsoncpp_example/CMakeFiles/jsoncpp_example.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/jsoncpp_example.dir/depend

