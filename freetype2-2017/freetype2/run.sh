 /home/vagrant/touch_of_death/AFL/afl-clang-fast++ -g -O0 -rtlib=compiler-rt -lgcc_s -std=c++11 -I include -I . src/tools/ftfuzzer/ftfuzzer.cc  objs/.libs/libfreetype.a  -L /usr/local/lib -larchive     -o ftfuzzer
 /home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -- ./ftfuzzer ../seeds/TestKERNOne.otf
 /home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -- ./ftfuzzer ../seeds/TestGLYFOne.ttf
../../../../../pin/pin -t ../../../../../tracer/obj-ia32/trace.so -o freetype_KERN.record -- ./ftfuzzer ../seeds/TestKERNOne.otf
../../../../../pin/pin -t ../../../../../tracer/obj-ia32/trace.so -o freetype_GLYF.record -- ./ftfuzzer ../seeds/TestGLYFOne.ttf