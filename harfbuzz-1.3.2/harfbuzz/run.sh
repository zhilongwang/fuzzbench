cd src/hb-ucdn
CCLD="/home/vagrant/touch_of_death/AFL/afl-clang-fast++ -g -O0" make
make -j 3 -C src fuzzing
/home/vagrant/touch_of_death/AFL/afl-clang-fast++ -g -O0 -std=c++11 -I src/ test/fuzzing/hb-fuzzer.cc  src/.libs/libharfbuzz-fuzzing.a -o hb-shape-fuzzer
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -- ./hb-shape-fuzzer config.log

../../../../../pin/pin -t ../../../../../tracer/obj-ia32/trace.so -o harf.record -- ./hb-shape-fuzzer config.log
