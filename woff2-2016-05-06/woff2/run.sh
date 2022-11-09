CC=/home/vagrant/touch_of_death/AFL/afl-clang-fast CXX=/home/vagrant/touch_of_death/AFL/afl-clang-fast++ CFLAGS="-g -O0" CXXFLAGS="-g -O0" make
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./woff2_decompress ../oss-fuzz/seeds/LinLibertineO.woff2
# /home/vagrant/touch_of_death/AFL/afl-clang-fast++ -g -O0 target.cc -I src/ -o fuzzer *.o
# /home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./fuzzer ../oss-fuzz/seeds/Ahem.woff2
# ../../../../../pin/pin -t ../../../../../tracer/obj-ia32/trace.so -o woff.record -- ./fuzzer ../oss-fuzz/seeds/Ahem.woff2
