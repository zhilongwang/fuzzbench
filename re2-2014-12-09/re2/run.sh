/home/vagrant/touch_of_death/AFL/afl-clang-fast++ -O0 -g -o target target.cc -I . obj/libre2.a -lpthread
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/re2-2014-12-09/re2/obj/so
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out obj/test/re2_test
/home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o re.record -- obj/test/re2_test

