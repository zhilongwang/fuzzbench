/home/vagrant/touch_of_death/AFL/afl-clang-fast++ -g -O0 -rtlib=compiler-rt -lgcc_s -std=c++11 standard_fuzzer.cpp -o standard_fuzzer -DSTANDALONE ../../src/.libs/libproj.a -lpthread -I../../src/
TRIGGER_VARIABLES=true ./standard_fuzzer seeds/epsg
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out ./standard_fuzzer
/home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o proj4.record -- ./standard_fuzzer

