
CC=/home/vagrant/touch_of_death/AFL/afl-clang-fast CXX=/home/vagrant/touch_of_death/AFL/afl-clang-fast++ CFLAGS="-g -O0 -rtlib=compiler-rt -lgcc_s" CXXFLAGS="-g -O0 -rtlib=compiler-rt -lgcc_s" ./configure --enable-static --disable-shared     --with-glib=no --with-cairo=no
/home/vagrant/touch_of_death/AFL/afl-clang-fast++ -g -O0 -rtlib=compiler-rt -lgcc_s  -std=c++11 -I src/ test/fuzzing/hb-fuzzer.cc src/.libs/libharfbuzz-fuzzing.a $FUZZER_LIB -o hb-shape-fuzzer

/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -- ./main ../test/shaping/fonts/sha1sum/ffa0f5d2d9025486d8469d8b1fdd983e7632499b.ttf
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -- ./test-buffer-serialize ../test/shaping/fonts/sha1sum/ffa0f5d2d9025486d8469d8b1fdd983e7632499b.ttf
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -- ./test-size-params ../test/shaping/fonts/sha1sum/ffa0f5d2d9025486d8469d8b1fdd983e7632499b.ttf
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -- ./test-would-substitute ../test/shaping/fonts/sha1sum/ffa0f5d2d9025486d8469d8b1fdd983e7632499b.ttf
../../../../../../pin/pin -t ../../../../../../tracer/obj-ia32/trace.so -o records/hb-main.record -- ./main ../test/shaping/fonts/sha1sum/ffa0f5d2d9025486d8469d8b1fdd983e7632499b.ttf
../../../../../../pin/pin -t ../../../../../../tracer/obj-ia32/trace.so -o records/test-buffer-serialize.record -- ./test-buffer-serialize ../test/shaping/fonts/sha1sum/ffa0f5d2d9025486d8469d8b1fdd983e7632499b.ttf
../../../../../../pin/pin -t ../../../../../../tracer/obj-ia32/trace.so -o records/test-size-params.record -- ./test-size-params ../test/shaping/fonts/sha1sum/ffa0f5d2d9025486d8469d8b1fdd983e7632499b.ttf
# ../../../../../../pin/pin -t ../../../../../../tracer/obj-ia32/trace.so -o records/test-would-substitute.record -- ./test-would-substitute ../test/shaping/fonts/sha1sum/ffa0f5d2d9025486d8469d8b1fdd983e7632499b.ttf



