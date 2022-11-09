/home/vagrant/touch_of_death/AFL/afl-clang-fast++ -g -O0 -std=c++11 -I. zlib_uncompress_fuzzer.cc -o fuzzer ./libz.a
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./fuzzer ./configure.log.gz
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./example
/home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o  zlib.record -- ./fuzzer ./configure.log.gz
../../../../../pin/pin -t ../../../../../tracer/obj-ia32/trace.so -o records/zlib_fuzzer  -- ./fuzzer ./configure.log.gz
../../../../../pin/pin -t ../../../../../tracer/obj-ia32/trace.so -o records/zlib_example -- ./example
