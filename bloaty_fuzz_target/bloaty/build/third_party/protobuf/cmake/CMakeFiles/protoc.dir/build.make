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
CMAKE_SOURCE_DIR = /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build

# Include any dependencies generated for this target.
include third_party/protobuf/cmake/CMakeFiles/protoc.dir/depend.make

# Include the progress variables for this target.
include third_party/protobuf/cmake/CMakeFiles/protoc.dir/progress.make

# Include the compile flags for this target's objects.
include third_party/protobuf/cmake/CMakeFiles/protoc.dir/flags.make

third_party/protobuf/cmake/CMakeFiles/protoc.dir/__/src/google/protobuf/compiler/main.cc.o: third_party/protobuf/cmake/CMakeFiles/protoc.dir/flags.make
third_party/protobuf/cmake/CMakeFiles/protoc.dir/__/src/google/protobuf/compiler/main.cc.o: ../third_party/protobuf/src/google/protobuf/compiler/main.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object third_party/protobuf/cmake/CMakeFiles/protoc.dir/__/src/google/protobuf/compiler/main.cc.o"
	cd /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/protobuf/cmake && /home/vagrant/touch_of_death/AFL/afl-clang-fast++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/protoc.dir/__/src/google/protobuf/compiler/main.cc.o -c /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/protobuf/src/google/protobuf/compiler/main.cc

third_party/protobuf/cmake/CMakeFiles/protoc.dir/__/src/google/protobuf/compiler/main.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/protoc.dir/__/src/google/protobuf/compiler/main.cc.i"
	cd /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/protobuf/cmake && /home/vagrant/touch_of_death/AFL/afl-clang-fast++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/protobuf/src/google/protobuf/compiler/main.cc > CMakeFiles/protoc.dir/__/src/google/protobuf/compiler/main.cc.i

third_party/protobuf/cmake/CMakeFiles/protoc.dir/__/src/google/protobuf/compiler/main.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/protoc.dir/__/src/google/protobuf/compiler/main.cc.s"
	cd /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/protobuf/cmake && /home/vagrant/touch_of_death/AFL/afl-clang-fast++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/protobuf/src/google/protobuf/compiler/main.cc -o CMakeFiles/protoc.dir/__/src/google/protobuf/compiler/main.cc.s

# Object files for target protoc
protoc_OBJECTS = \
"CMakeFiles/protoc.dir/__/src/google/protobuf/compiler/main.cc.o"

# External object files for target protoc
protoc_EXTERNAL_OBJECTS =

third_party/protobuf/cmake/protoc-3.9.1.0: third_party/protobuf/cmake/CMakeFiles/protoc.dir/__/src/google/protobuf/compiler/main.cc.o
third_party/protobuf/cmake/protoc-3.9.1.0: third_party/protobuf/cmake/CMakeFiles/protoc.dir/build.make
third_party/protobuf/cmake/protoc-3.9.1.0: third_party/protobuf/cmake/libprotoc.a
third_party/protobuf/cmake/protoc-3.9.1.0: third_party/protobuf/cmake/libprotobuf.a
third_party/protobuf/cmake/protoc-3.9.1.0: /usr/lib/i386-linux-gnu/libz.so
third_party/protobuf/cmake/protoc-3.9.1.0: third_party/protobuf/cmake/CMakeFiles/protoc.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable protoc"
	cd /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/protobuf/cmake && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/protoc.dir/link.txt --verbose=$(VERBOSE)
	cd /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/protobuf/cmake && $(CMAKE_COMMAND) -E cmake_symlink_executable protoc-3.9.1.0 protoc

third_party/protobuf/cmake/protoc: third_party/protobuf/cmake/protoc-3.9.1.0


# Rule to build all files generated by this target.
third_party/protobuf/cmake/CMakeFiles/protoc.dir/build: third_party/protobuf/cmake/protoc

.PHONY : third_party/protobuf/cmake/CMakeFiles/protoc.dir/build

third_party/protobuf/cmake/CMakeFiles/protoc.dir/clean:
	cd /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/protobuf/cmake && $(CMAKE_COMMAND) -P CMakeFiles/protoc.dir/cmake_clean.cmake
.PHONY : third_party/protobuf/cmake/CMakeFiles/protoc.dir/clean

third_party/protobuf/cmake/CMakeFiles/protoc.dir/depend:
	cd /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/third_party/protobuf/cmake /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/protobuf/cmake /home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/bloaty_fuzz_target/bloaty/build/third_party/protobuf/cmake/CMakeFiles/protoc.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : third_party/protobuf/cmake/CMakeFiles/protoc.dir/depend
